import { useState, useCallback } from 'react';
import { useNavigate } from 'react-router';
import { adminLogin, adminLogout, adminVerify } from '../api/admin.js';

const AUTH_KEY = 'admin_authenticated';

export function useAdminAuth() {
  const [isAuthenticated, setIsAuthenticated] = useState(
    () => localStorage.getItem(AUTH_KEY) === 'true',
  );
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const login = useCallback(
    async (password) => {
      setLoading(true);
      setError(null);
      try {
        await adminLogin(password);
        localStorage.setItem(AUTH_KEY, 'true');
        setIsAuthenticated(true);
        navigate('/admin');
      } catch (err) {
        setError(err.message || 'Login failed');
        setIsAuthenticated(false);
      } finally {
        setLoading(false);
      }
    },
    [navigate],
  );

  const logout = useCallback(async () => {
    await adminLogout().catch(() => {});
    localStorage.removeItem(AUTH_KEY);
    setIsAuthenticated(false);
    navigate('/admin/login');
  }, [navigate]);

  const verify = useCallback(async () => {
    try {
      const { authenticated } = await adminVerify();
      if (!authenticated) {
        localStorage.removeItem(AUTH_KEY);
        setIsAuthenticated(false);
      }
      return authenticated;
    } catch {
      localStorage.removeItem(AUTH_KEY);
      setIsAuthenticated(false);
      return false;
    }
  }, []);

  return { isAuthenticated, error, loading, login, logout, verify };
}
