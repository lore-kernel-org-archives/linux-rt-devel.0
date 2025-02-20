Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435B1EE019
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044281; cv=fail; b=iguAGW3EDSuUbesXGFe23HrHYlkmZxwxPwVjh0VNQu7fiRHxYq6a+cUCtH8gMoWH3BXnRoXmesDgBFWGock87RD40REWyl8DsSfd3Pgw9BBxHdQrJSZpmPUeB9IJfoAUDmUV4uSYEM8VdRbhlUty3tnX8HjoLIUcrckzdD6EDZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044281; c=relaxed/simple;
	bh=TcEor6K/5IJGnDlcRajSnsACMAxcQHuMu0F7nrgJc2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9dCOWdc/8JfkQcIoRkWR1/MfsTwO6TPjzb8hP4OwmT75KGR8pnggu8JNtidEVfKeglmIdRrHX+gnR7S3qit1Ddag0iX5Zuxi1QvTlxmZ+78FwDlxZOqD6ygJd17uvj7tKOjoAjnEN45ECI/5JeKqi1zgbbLlX0iWNfOMbmaIdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpT7deOR; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpT7deOR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUDsPuGkYUNLlSochvzII3gm953Yk+YhxwKiehEquP5Z1rCP3Y/WR+07lEidWd+5hrWfyr2HJODmtpGjJ5mblmfjJW6EFmAKU8jhwyAZyELPBIVL3I3owiOOtKZeG1V3kPySiUX79frkwaCTLkt9aroWmMkMc7tXMik0V6AYEySb/BEBh0GZvrfPuebnUMGKfU2qbZ7w+IhqwcHY4hFUYW060l9+fRgcQVpFmhYP94+Yq9Kjpuf5cMVEPpZVV5vRMj3xIXx9nSBAeDTVoHuvj0l9gt9jmR1OsHqHKtrWvPiATN6rNMHXG2o2rqQhwyRogWOHlNniySkdDDx3v+EjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpeMy8jI0CI1cCJJtAuSHemhXiOxLJ+rQiLNO+zDyhc=;
 b=SOlVJ96r1OtW1PkGp0ZFWR7EMJ+PjoQDSj33cF/fmRnkXjpiXVJWLFC6PNANpkwXIVjenS+5EH7soH08COhWpbU08YJ/0RP/G3vSmUrjpPO0A3SP8+wnXyGO93Kbn/RvQkmomKnEoRL4z7KWJFAT8LEBOFt4kyAGVqwNhfXlRp83WTWk/X73NkSdrqQuYKCnTzR8qXcYUNbV67WOyLQZEVCZn2NfVgzLHI8VsvMk7GkQzUGO2SBsw8OWNtS2S7eK5slBCKu8vyWW2XY2VvojkXsXisWaWjusGXQtyKCSZ3Cf25eNcCImGSAu31/rl091/QAMesqeBVNOZM235dXQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpeMy8jI0CI1cCJJtAuSHemhXiOxLJ+rQiLNO+zDyhc=;
 b=SpT7deORVpbOY+0FT9AMVSIF1HnOL8TpEooTIkmeST4nBKXZFog3qSrHPcyFb+aK0/LZrsTKudpyTY4FdLm1Byub9zObsFzjkuDkJXP3SaPIS9VDbtCp/ytbj9z/4Mw1NfrRGyCYlaU+/gSYyPV3lAwuvHHAHjYN6Sy6sFHrOTM=
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:37:57 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::f6) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:37:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:37:49 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Ben
 Segall" <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Andy
 Lutomirski" <luto@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Tejun Heo <tj@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, Barret Rhoden <brho@google.com>, "Petr
 Mladek" <pmladek@suse.com>, Josh Don <joshdon@google.com>, Qais Yousef
	<qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David Vernet
	<dvernet@meta.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 13/22] sched/fair: Correct the throttle status supplied to pick_eevdf()
Date: Thu, 20 Feb 2025 09:32:48 +0000
Message-ID: <20250220093257.9380-14-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220093257.9380-1-kprateek.nayak@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: caa4601b-a1f6-423d-6238-08dd5192421f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdMPnhCXQ4wVYv0BHIL4AHFfWswa/svYt8yupSCoMz0W5Cf9kgUhTkSK0sdY?=
 =?us-ascii?Q?6cJyA99KT4gy215S8xq7X9+sjg1rOrDlmgt24SZ4L6jgWW4jbQtnMXMEPPGg?=
 =?us-ascii?Q?+vJXe8kKcxMd6Tti8WD4Gr7Y6iA0HLTmKcOp/pSmRMLZTZgtiEJkp7qPKQ9a?=
 =?us-ascii?Q?01ZdwZy2tWzC0kjZ11BnRxkaK/G+1HfswHWgFhfscv2uPsYG7v5sf7mOT6Wy?=
 =?us-ascii?Q?WQSvsvo5/auDswpO0HM5LwU/RPSrcw0NZDpx0dx63VzCoUXwRuMKVJHq8SDf?=
 =?us-ascii?Q?ESVUt+Xjn1GIGp2Al7ug+OB4mYcQ1DwbnbVwO/3Q0hfyllsJi8Ic8Mbzy4ae?=
 =?us-ascii?Q?DRhPIjcRubU7khXbl5Q9Rzsv8b3spaIvqIl6wva7qVE7ysCKpjAKtXB40xdI?=
 =?us-ascii?Q?/QMXIcr/nze3S8hnq51C3VXNnSfZqWGANcIJ5sO3WAog2l2sXG/Nu/hsBHu+?=
 =?us-ascii?Q?ZeZ/l42nEYRqSv477QE4S2GgOSyuA9Esd7Bqt5pvopD4DxESMqeEosRI7sU5?=
 =?us-ascii?Q?6MCPKHLhAzuWYVx/a/g4NuXuuhGDy94nKU7g4W1ztFGlSRlCKYfn0N8piszW?=
 =?us-ascii?Q?OqYDiG9ozjMjhJf4oZKjBs4bfRNpxPEIhOFhIGeDKy67ieq3abIxu9q77jR7?=
 =?us-ascii?Q?qq+zsagGPUUKvOTj+WJPtaE4s/GUgWAOMeBXlVamgJbTn9TOmV+RtMLdGD3w?=
 =?us-ascii?Q?X2IxJeKKXs8XYLiWUuawPcIkMdqi2FjD7dPxF4zGX8EJDRF2xNbXnyXJieZb?=
 =?us-ascii?Q?V7geTwRkbG1qFCBsawYilgULlyVGIXZTR5uoNJ80WnsWDUJBGjqYbJJ70Bo8?=
 =?us-ascii?Q?tyxiJZVhPb7d9S4AIg499gEmEibi8EfLNFhNsYAzG6+K5gHCKRVpTeGNaBS6?=
 =?us-ascii?Q?ZqmfO1K0cshaKvTJm5yk0OOYTcRsUoDXV8gKSsGBfDFioqDZw500hoeSXMPJ?=
 =?us-ascii?Q?gBBXkzyg2BYwm63gPVCWieFiH8b4IZuTDm4J9lTFfSalR5qlUfsIaMT8nhJv?=
 =?us-ascii?Q?QWFu0/HcIe6fDQ1gZDe3z9yfuYvyuntOmk1ouOj5eNQwh/k9UZ8yYe9Gi+CT?=
 =?us-ascii?Q?ZytTf6Ur8x8Kl3dE05Dr5RZ67jXYJAlgHCC2ibVwfFBKxt/Aqq3tM+t0CZjb?=
 =?us-ascii?Q?AyRuvvJipV+J4qDHxNkXCjD9AV7ySvfomyQ/8gFI04J6+DH1czeFoiRcEeke?=
 =?us-ascii?Q?8QRtizC7QkB8JhZhfpdnAD3jmTTDtPooas+lENvunU2FEqw2fCm9LQQbtUC8?=
 =?us-ascii?Q?ivY38CFKnAC9m/BOeMMSQmpLxWZ3kcgT0s79IuhodzJwTf0Pn0nKWhLB9Bm+?=
 =?us-ascii?Q?TLv3EYccQO5jtwamy8Bu2g8YTkOXdjaI5+K2nxjoTPXOdRczabKWb87oEu1+?=
 =?us-ascii?Q?Uxy4YzdHBS4C0RaRh59gOH3LNs0WQK+VLIrEqB3/Y04yxR+BVnVyEllMijgQ?=
 =?us-ascii?Q?RXIYNu1nsjShEMElZtn8x92o3crmVLaLACC7T1Q+JKGn0xAXq89zhoTZlcW8?=
 =?us-ascii?Q?Vng4ZTSyr5HAd54=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:37:57.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa4601b-a1f6-423d-6238-08dd5192421f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691

A partially throttled hierarchy does not set the hierarchical indicator.
Find the throttled status of the hierarchy when traversing down the tree
in pick_task_fair() and pass the correct throttle status to
pick_eevdf().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8824e89a3ede..1d871509b246 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5618,7 +5618,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
+pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq, bool h_throttled)
 {
 	struct sched_entity *se;
 
@@ -5626,13 +5626,13 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
 	if (sched_feat(PICK_BUDDY) && cfs_rq->next &&
-	    pick_entity(cfs_rq, cfs_rq->next, throttled_hierarchy(cfs_rq))) {
+	    pick_entity(cfs_rq, cfs_rq->next, h_throttled)) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
 
-	se = pick_eevdf(cfs_rq, throttled_hierarchy(cfs_rq));
+	se = pick_eevdf(cfs_rq, h_throttled);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
@@ -9187,6 +9187,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
+	bool h_throttled = false;
 
 	if (unlikely(se == pse))
 		return;
@@ -9260,10 +9261,16 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (do_preempt_short(cfs_rq, pse, se))
 		cancel_protect_slice(se);
 
+	for_each_sched_entity(se) {
+		h_throttled = h_throttled || cfs_rq_throttled(cfs_rq_of(se));
+		if (h_throttled)
+			break;
+	}
+
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (pick_eevdf(cfs_rq, throttled_hierarchy(cfs_rq)) == pse)
+	if (pick_eevdf(cfs_rq, h_throttled) == pse)
 		goto preempt;
 
 	return;
@@ -9276,12 +9283,15 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
+	bool h_throttled;
 
 again:
 	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_queued)
 		return NULL;
 
+	h_throttled = false;
+
 	do {
 		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
@@ -9290,7 +9300,8 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;
 
-		se = pick_next_entity(rq, cfs_rq);
+		h_throttled = h_throttled || cfs_rq_throttled(cfs_rq);
+		se = pick_next_entity(rq, cfs_rq, h_throttled);
 		if (!se)
 			goto again;
 		cfs_rq = group_cfs_rq(se);
-- 
2.43.0

