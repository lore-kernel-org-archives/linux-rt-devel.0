Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE271EDA08
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044261; cv=fail; b=ZPVAUCOlLjnl4Ubp7gZFwCo8QBPBcdY5i8Z+93oBtYx5iwzf4tXu9lWMq7fcAtFkhekdQbmy7JM38lAVwBy+ODXuIhy8C5EVSAx77NUMgy9gGwLc0qio+WBtcvwhORTvNoVFVKrJQTYXPbb7cE9ZLslzBq3KeUPpKBW3Zv4RiT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044261; c=relaxed/simple;
	bh=PcaYm2DMYRsNqifk66WL6QIBqUjg0Wsrul82jbOHI3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjXwym9qK+JAnFBUEU2A91yu7eFJI2WpIrQCPHeAAyD1cKiOcoTmd73oyyca7KM8J0DwRYTXIN3t+eLjfLIMWgtvCNFHLlVgFRQzAd/YxJYQUlNmnAQVT8O5SqW+ACHn3N6OmRtmCNMwp1DA+g88WJPEBQvNhrkoxnptr1fx2+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=28sIhw1w; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="28sIhw1w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzUZaWl5RvwEFqZVqsum7F1TlauwkPYrGLzFziOtYGR7/2LaxAxOWqcyPeoaROrhZW1ZCaIrrSQgiJuZKjKNeeOB9oyveK1rOv7okn6dM6f5iSVhu8tHYaGFovKNU1Ia/mRiOkl2O0kFxJoj+fbip5Mq4yr9JlsNrgJqSQRbnRKb3AR3L/SkZ2xgPy5+MKS0wyrmhFD0ZofrjNLNHZJhUY3P5BiBae2zmKNpINL6f5sOyexZIFKsfSVKM0O8/aB9Pv4wvuLKIepXb3sLJzxQ1fH6iZIbISnXC1/EDnyJJOUU0qx+Zt3Rz4tg5t6Dcm/l3K86qIbmgzMZRPknUrLOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH1v9eBHjwLdmS8FXD8Br5M04r9aHqs2WF3ePVt2370=;
 b=uAzy3C4T+3AqJoM9WBNlyUXiBf2XsDP2QZHo4RwRO62BzXj4aVaKqkQvlxc1y1Tgwng2VOo4cC7KXGADzm1e8nd79Iw3/GGcZh4khYXhUh3VdDzZQz0Z3AaU3hT3Fh59TV8sHNDl1Ozk3SICF1fkxUZ/ekhjw23k+V/xJFZjoTdS1LgRv9WWway3GlrBTTFtsLxMMUNImFUL8FbStVRp1ZJcJ1R6yRB6AaOV3eaabv70kPvuBCm6xKEZMQf6P1KgadjGaL0aAaNEFZDH44TAWJ4QV92kc/RDtYw2dHO+IWdGuR6hW4oiu5NJ2kGjnqVHe0vn9ag2NM095B5s1tQrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH1v9eBHjwLdmS8FXD8Br5M04r9aHqs2WF3ePVt2370=;
 b=28sIhw1w4rZyyN+5Wruo6NCBpwv7Tuoc7V0FIKWjDFOqjdrxETjpljfHw6usJ/7YcrDdWcT2Ept0Wo6a0EHhT8TRFEuUVoVGg3K92BcwIx2mXjru46tffNkij7GapQUT8QvKxpIOiTbKCrFySkgnI2Gqi21HkN4PJaY4orS0yHU=
Received: from CH2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:610:57::39)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:37:36 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::b9) by CH2PR12CA0029.outlook.office365.com
 (2603:10b6:610:57::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 09:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:37:36 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:37:28 -0600
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
Subject: [RFC PATCH 12/22] sched/fair: Prepare bandwidth distribution to unthrottle partial throttles right away
Date: Thu, 20 Feb 2025 09:32:47 +0000
Message-ID: <20250220093257.9380-13-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: e2324ae2-6293-4fd5-3f39-08dd5192359a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5DuPx6xi1sht0Cqh8Pozyj7dulx+0nxgMqOKjKFEqdjYBKM/7TYAyDnqlcg?=
 =?us-ascii?Q?V8eI+7oQhxobP9vX9FgVoPNS3G7kEQ4xPsYS38/r9cJ8P46tTrVputTxKlJA?=
 =?us-ascii?Q?x6KnqIIAZqvyWW9hPX8xBQ/qZ/6+EWnB2YkSKWoQ3C/nS8ZRIFGK+jWSEjwn?=
 =?us-ascii?Q?7Mm9foR1ZZJqTcs9l9823EL3Zbd8HUFMJwjQEbmsk1gJiDs1AuLteXvDbTEY?=
 =?us-ascii?Q?RoyTZzOGt1kFHCKER729mdAsNaQUbM2mrbMai9Rp+nm/lq4/heOXFWORKNeP?=
 =?us-ascii?Q?9cur5QmwfsfM40/9ATSP8C6ASqQ8L0gn4GZQClCWIew5EMJajZFjs9aaARn9?=
 =?us-ascii?Q?2Ucv6GK1xfRA0svXb3GyuRdGwDC8n8dvwhvNnxgtB1HnxhiMw0BSf6WTd72b?=
 =?us-ascii?Q?pEY9/LRVKzWP6gOXGRER+70wtHhn1OyTlWTXSGpr+LKSi7zLNzoPOdf5iGsL?=
 =?us-ascii?Q?ztkOvlx58NMGXPBnd9VvJeVMl6Go4DaDmYQmcSc3U1q93TXz7mXEZY+7R/oj?=
 =?us-ascii?Q?TKUU9aqYkJifsr1m2WIvCwMiGTTNz6Tjyewaa6LIteKYC/8rzTR+8BIAbmj9?=
 =?us-ascii?Q?d5kdPu4EOCfSYssIDtKF4WjJ4uAVGuDXjQ0qY0Fin5w+dYqhct1ga5El2iZR?=
 =?us-ascii?Q?dcCbVa22H2OdkAl6tegRXf/l754r5Vz0fGOGjt6tux46sm2THgJilAXn0oPu?=
 =?us-ascii?Q?nGthu1MbiR88XVeV7Mn6WwmTQpN01cu3Gopz1SWITU/w2ICsoyFIc4EBtz+9?=
 =?us-ascii?Q?wfcfwY4zi83ZY3QIdJN81Wtfy1dDCFjEWOoWidV+dqNsKkhwqp5afPQ1xUWN?=
 =?us-ascii?Q?scp+3nENFevVqAvMUcWBjerbWDArPgSTu01ShATMMQkPgsMPv5Aza9OaVAOu?=
 =?us-ascii?Q?ESFWNLdvqAkosfSiBV71RUH3GawpzFastaQYCgWe/Kx3nQ6/uffFWCcfdfbe?=
 =?us-ascii?Q?B9f5sNXjYrr37dMe9NqG1BE9mE1MOTsRtQOICXI/4QrXZPaJ6rjPTeW+w85c?=
 =?us-ascii?Q?nZQzowNpJUSm7vxGw47CvO5Z72r9d+omrEEPHuRs7xaloxRfyfoF0p+LKwIa?=
 =?us-ascii?Q?cUkYP+0ZxXNpr5lz76DFCOQ0uZvj8iLHL5njUcipDVyf7TRTpjjUy1CsbJDN?=
 =?us-ascii?Q?HZvU33bo8EUB3HhymWJvEhYFWCVpr+WvuOFf2Gf0HhPwPto8X6cjcI1EQ20y?=
 =?us-ascii?Q?eTmfvXOuoKz3segyGhmd3fRJrFfxJJVWZxHvgf5NU5jEApWhB0z0X3oiJ2Wl?=
 =?us-ascii?Q?nILSLJgHMjHBLI8J/Pr/TQM8JzI1IE21PiHx4zXcTLDq90CX/m4/wbULU/Vk?=
 =?us-ascii?Q?GMZAZ5H9vI7Hve8bqQGhMeRh8uebjgv0ylTvMeXLDbrul87Zbc+YbZ8XoUJV?=
 =?us-ascii?Q?Bw7D71i+mPzOKkwjkgmc1ycZgVuerxNkswo4O0z9jYASOQTitLBVEtylsEW3?=
 =?us-ascii?Q?k+4yjM06nF1OCmL98lFLpbCWg5MbM5aeuirHVwGeaBb/1HEiFSLSdD+E5F8L?=
 =?us-ascii?Q?DSh/SpNWX7MdZzI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:37:36.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2324ae2-6293-4fd5-3f39-08dd5192359a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

Unthrottling a partially throttled hierarchy is cheap since it only
involves updating the cfs_rq's throttle status and does not involve
modifing the hierarchical indicators via tg_tree walks or enqueuing the
cfs_rq back.

Unthrottle a partially throttled cfs_rq right away. This also helps
avoiding a subtle race with async throttling, specifically:

  distribute_cfs_runtime()
    rq_lock_irqsave(rq)
    # Replenish bandwidth		schedule()
    unthrottle_cfs_rq_async()		  local_irq_disable()
      smp_call_function_single_async() -> # IPI pending
    rq_unlock_irqrestore()		  rq_lock()
					  pick_task_fair()
					    check_cfs_rq_runtime()
					    # runtime_remaining > 0 but
					    # cfs_rq->throttled != 0

The above can lead pick_eevdf() failing to find a sched_entity which is
now avoided.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 091493bc8506..8824e89a3ede 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6320,6 +6320,17 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0) {
+			/*
+			 * Partially throttled cfs_rq is cheap to unthrottle
+			 * since they only require updating the throttled
+			 * status of cfs_rq. Save the need for reacquiring the
+			 * rq_lock and a possible IPI by unthrottling it here.
+			 */
+			if (!cfs_rq_h_throttled(cfs_rq)) {
+				unthrottle_cfs_rq(cfs_rq, false);
+				goto next;
+			}
+
 			if (cpu_of(rq) != this_cpu) {
 				unthrottle_cfs_rq_async(cfs_rq);
 			} else {
-- 
2.43.0

