SELECT
q.ParticipantId,
q.VisitID,

BG.BCK,
BG.CTOF,
((q.T100_1+q.T100_2)/2)-BG.BCK AS T_100,
((q.T400_1+q.T400_2)/2)-BG.BCK AS T_400,
((q.T1600_1+q.T1600_2)/2)-BG.BCK AS T_1600,
((q.T3200_1+q.T3200_2)/2)-BG.BCK AS T_3200,
((q.T6400_1+q.T6400_2)/2)-BG.BCK AS T_6400,
((q.T12800_1+q.T12800_2)/2)-BG.BCK AS T_12800,
((q.T25600_1+q.T25600_2)/2)-BG.BCK AS T_25600,
((q.T51200_1+q.T51200_2)/2)-BG.BCK AS T_51200,
((q.T102400_1+q.T102400_2)/2)-BG.BCK AS T_102400,
((q.T204800_1+q.T204800_2)/2)-BG.BCK AS T_204800,
((q.T409600_1+q.T409600_2)/2)-BG.BCK AS T_409600,

FROM "ELISA JRCSF gp120" q


INNER JOIN

(SELECT 
q.VisitID,
AVG(((q.neg_1+q.neg_2)/2)) AS BCK,
--determination of an endpoint cutoff value by averaging background plus three standard deviations
(AVG(((q.neg_1+q.neg_2)/2)) + 3*(STDDEV((q.neg_1+q.neg_2)/2))) AS CTOF
FROM "ELISA JRCSF gp120" q
--if cutoff is to be determined by plate can add in plateID if available.
GROUP BY q.VisitID) BG

ON 
q.VisitID= BG.VisitID
