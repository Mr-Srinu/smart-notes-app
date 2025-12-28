import * as controller from '../controllers/task_controller';

console.log('CONTROLLER EXPORTS:', controller);

import { Router } from 'express';

const {
  createTask,
  getTasks,
  getTaskById,
  updateTask,
  deleteTask
} = controller;

const router = Router();

router.post('/', createTask);
router.get('/', getTasks);
router.get('/:id', getTaskById);
router.patch('/:id', updateTask);
router.delete('/:id', deleteTask);

export default router;

