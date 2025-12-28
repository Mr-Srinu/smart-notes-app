import { describe, it, expect } from 'vitest';
import { classifyTask } from '../services/classification_service';

describe('Task classification service', () => {
  it('detects scheduling category', () => {
    const result = classifyTask('Meeting with team');
    expect(result.category).toBe('scheduling');
  });

  it('assigns high priority for urgent tasks', () => {
    const result = classifyTask('Urgent task today');
    expect(result.priority).toBe('high');
  });

  it('extracts date entities', () => {
    const result = classifyTask('Meeting today');
    expect(result.extracted_entities.dates).toContain('today');
  });


});
