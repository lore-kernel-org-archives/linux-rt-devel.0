Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF931EDA08
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044202; cv=fail; b=V+oSLtT7bbL9v2IFxwki6DYNTcrurnyBBeZEUks0OPcCBcRtpOBdhJSZQC3V4FMLD8Fmhq2ZKngKcdryT/EUROuaBE3hrV50iSR27L0vSbJl1dIKuaEXCYltH+s4baLb78QJ5iyAA3ycOZXiITEgoNV0oUlsFXFHr9kHd1t5EU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044202; c=relaxed/simple;
	bh=6iR4/BgPsAII7PNwhW2SB9bzncZ4b9IL78w7NlC7Kww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nez+3zwUrLBfdXe5hoFcrQqIqsOlhaZnzB5c6An4/GWXhhOQy0Xf4ol8Gcg9APpKMG/UsihkodUya9dKiu69cGCCmc2TziQSt8lCFux++xqNkYdThShScP2pt074s+bQdEmOnc7qSdm3clzoUlEWR6p7DYeQO+wrpSpPn6+f5nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RGzO8FWr; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RGzO8FWr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Brs+TZK3Uv+R0PSxzjjUAyTkHpV+Zv4WDWEc2VYqJwHCnxwW0qBtqqXAiercmZSuGqCl3ZZ4y0GZKfUe+XucDCYq1IU2jv2WvTIWlKzsil24971N4xdGyNSaVPzTPrd8qunntYt9WmoWRSytkO0qaZI4g0g4/rHRjHIKIQH1gQK9YDI7DiyNNEn4crUJHSwWyqFNwUbb5VePTIvMRhy//6rjI3+LhHXws/K+FnxBwsDA7KzOxPOF6+N+x47scy+gJbLVuXzzC7bZiIOfvZzFHps8fpZu2H4Lo+O43Ehw4s2Q3XbRzu0CaOItLv+HjS+/VIf+UizPYzJX5MLgHZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j04M7FpuFUmb8dwl4D/pdyEWwDHPVe4vDdGMefBm8AE=;
 b=dHddA/0UMGCrVYD6ZUVcZVK6BzqcKbPDt8BHqdjctZ8J43nJKcK5LrQ/4CVYkVSHgx7awA49A6YwPZ7GNNws5Yicky3Uo/M6oxwRfw+Iv6ydo1pNVw/uwQMmxD6uuY08rP4tAo6FznmwxRhIbrpgcsWFblDX5+BROot7KjgoZujq5H2gcfnGITsN0YWqp0skOAlSlDLox5kom/6DNrw5x5Mxt9dIwfyP6YfGUTXoFsuTR+5GIgtk7aT8Ti0hnbCBOjjvJhI8u81FpLsUFPg8faUOGqAM6j6qLqVnVgIHSExgb3u1V2k+1wKQhzBE7fZp8YacAF4s1sCySAlIJY7t+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j04M7FpuFUmb8dwl4D/pdyEWwDHPVe4vDdGMefBm8AE=;
 b=RGzO8FWrnZLdHu911eiU7mMLkQMeOen8hk2IjFqr4sXHzaGV/2e54Cw2IMGEJLIolF0SBWPY+joJCcH8f1xAs8HvtU4LrwA0RRbJao41ySjhAIXkI2s/HLK1iJDjAgMEYngcSikrmN/Tz/cV4oJbhjKDY5S+GcRFqxThA2hP3S0=
Received: from DM6PR02CA0163.namprd02.prod.outlook.com (2603:10b6:5:332::30)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 09:36:33 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::11) by DM6PR02CA0163.outlook.office365.com
 (2603:10b6:5:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 09:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:36:33 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:36:25 -0600
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
Subject: [RFC PATCH 09/22] sched/fair: Introduce cfs_rq throttled states in preparation for partial throttling
Date: Thu, 20 Feb 2025 09:32:44 +0000
Message-ID: <20250220093257.9380-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1c438d-8660-4e5f-4814-08dd5192103b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXL6aTFi+OTbVShSjtT5T1xbMXeQV6/M9zfOli8tDWZL2FwWsiggJPMh9CyV?=
 =?us-ascii?Q?4bjtJWdgRSDvIPXXMuy+H/je8vtkfMrb2/HnWO7HanPHOeHQpOqe6Nzg7rbY?=
 =?us-ascii?Q?GUce8c8+oCtFeIdGz3RR7ccNlDWoKq5xBkQKn7jdfoJwDcvLBudkY2lwdrMa?=
 =?us-ascii?Q?9lZZD1s2tRb64VAjtbcJ+VRSUGvrsv0sDA/doRv+b/7YBgbdaJnDhxeCB2AZ?=
 =?us-ascii?Q?RboGYuN91WRRpkfhn5vS4zCOPQCr4c9U78QGTKcaa8L8tGkumGoeNperupHK?=
 =?us-ascii?Q?ePxtu4sxx83IUhMXmW3IKziZ+p6P2+56CrcKBsYRJomltWAX6cjFKRuxWJeu?=
 =?us-ascii?Q?1DzdC5ohdn9jdzUuhzvlfz8rOs+x2A+egJVOsBP3jVIH7S3BXs9JXJ4V82ZT?=
 =?us-ascii?Q?GqhxnvGJqAWpOOuUJF/TW+9Sy4HQl0RkCoD4aVSSqmLva1HCHd16o7hkTsoT?=
 =?us-ascii?Q?wlptcO88vhnQLuEVUBqyO+K9IeJQyHZHnw5XgD0tAdX/r6zWoHtRzXvYts2c?=
 =?us-ascii?Q?UlsREiSUNY94ebMJrkgL/Nx90VyhjljrDWorv5nFEna50Uyy26ShJvXJIDkV?=
 =?us-ascii?Q?Coq5ksim+cP+53bh+xS9gXrVhrxOndLGfESZe8KJFimlXF5Z0liJeIPx0c/C?=
 =?us-ascii?Q?hPxY3slhtIzdYa1iQcYF+pnIDf5IlgycK93mCt31d+E6qcT/TIjjPIXyrLmg?=
 =?us-ascii?Q?mANvjGACYbDsXJu3TrHOsgMzKN8BG0LwEe+qe5Hkbh0h2S6dWD40AzwwZSZr?=
 =?us-ascii?Q?1nEpDIp2C2rgs5ABioOJLcq1ftXPZhmmpZXw8olN5QCVYTX8AcfOAeaBci+F?=
 =?us-ascii?Q?tfjIXoKDfkkG1J07hMBqmsn38qVy/TlPX5GKM5A0EiYxauq3+jNoZbZqwqou?=
 =?us-ascii?Q?eduTOi04UrqAd6YhYKky8kkF1XB/OObMVol7d6DHyI8tbSjYdIcUCahSQcX6?=
 =?us-ascii?Q?/i8tK1ONbTRwNQ8yOd2g5cPbUk3W/61nvWwxc6ML6PAD+03FZS7IYH2DhzeS?=
 =?us-ascii?Q?1sv9i+LJbbx1UyuyLgwH8/WwKpKmFGt8kUXacQMYttwGnOF0gJ2hTtX9rDDH?=
 =?us-ascii?Q?1lJsDCXCHk/YsMkrstVZUmeKiQ9dVyyMkPVxU3TAdyMMlNvl1cQ+WB6La3i3?=
 =?us-ascii?Q?Hy9tlAYz7G5Uq7a45wvhQEoix9sPc3QNwxP/bfQ5lwKANmO5IG9x9g6gNTnE?=
 =?us-ascii?Q?mcpwzru+Mb8J0876/srlQE8zEvwuX3hz9JPAF2Ivn2nAnUqr8hRObNS2RYbi?=
 =?us-ascii?Q?hujqRS9A8md/G5p6noo5wCATqCzKIqjsQEZvoDq8RsdWmCWkEP7N3l8gEq4o?=
 =?us-ascii?Q?XGdyKfjL7SZ5PJEaQXwsD5Yb8RZqqaFLU5Waq3D24czbxsQ0rjS+1OjAgQcZ?=
 =?us-ascii?Q?95eyB0ptJHj1VxeZWjoQks0xFPVGk6jKpVFEk3yzJMbPWHNR9V0dGwtpOkgU?=
 =?us-ascii?Q?IlpSW6y/986G67Pc+5XQ47kQHWwEK5UJYfX5ffd4s0Jsm8EoYfzip8R0NBbY?=
 =?us-ascii?Q?+1YGG5uZPEUxt6E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:36:33.5092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c438d-8660-4e5f-4814-08dd5192103b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

On introduction of throttle deferral, cfs_rq on encountering a throttle
event with kernel mode preempted entities will be marked partially
throttled allowing only these kernel mode entities to run until they
sleep or exit to userspace.

Introduce "throttled_state" enum to define the three throttle states -
CFS_UNTHROTTLED, CFS_THROTTLED_PARTIAL, and CFS_THROTTLED. In addition
to cfs_rq_throttled() which will now track both partial and complete
throttle, introduce a new helper cfs_rq_h_throttled() to detect a
completely throttled hierarchy.

Convert appropriate cfs_rq_throttled() checks to cfs_rq_h_throttled() to
guard logic that only concerns with a complete throttle. Also take the
opportunity to convert any open coded references to cfs_tr->throttled to
use one of the two helpers.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 67 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4fd70012b479..c84cd2d92343 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5340,7 +5340,11 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+
+/* cfs_rq is throttled either completely or partially */
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
+/* cfs_rq is throttled completely and the hierarchy is frozen */
+static inline int cfs_rq_h_throttled(struct cfs_rq *cfs_rq);
 
 static void
 requeue_delayed_entity(struct sched_entity *se);
@@ -5404,7 +5408,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 #ifdef CONFIG_CFS_BANDWIDTH
 			struct rq *rq = rq_of(cfs_rq);
 
-			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
+			if (cfs_rq_h_throttled(cfs_rq) && !cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock = rq_clock(rq);
 			if (!cfs_rq->throttled_clock_self)
 				cfs_rq->throttled_clock_self = rq_clock(rq);
@@ -5448,7 +5452,7 @@ static void set_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable--;
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			break;
 	}
 }
@@ -5470,7 +5474,7 @@ static void clear_delayed(struct sched_entity *se)
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 		cfs_rq->h_nr_runnable++;
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			break;
 	}
 }
@@ -5817,7 +5821,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
-	if (cfs_rq->throttled)
+	if (cfs_rq_throttled(cfs_rq))
 		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
@@ -5836,11 +5840,37 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	__account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
+/* cfs_rq->throttled states */
+enum throttle_state {
+	/*
+	 * cfs_rq is unthrottled; All the queued entities
+	 * can be picked to run.
+	 */
+	CFS_UNTHROTTLED = 0,
+	/*
+	 * cfs_rq is only marked throttled. There are kernel
+	 * mode preempted entities that are still runnable.
+	 * PELT is not frozen yet.
+	 */
+	CFS_THROTTLED_PARTIAL,
+	/*
+	 * cfs_rq is fully throttled with PELT frozen. There
+	 * are no entities that are considered runnable under
+	 * throttle.
+	 */
+	CFS_THROTTLED
+};
+
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline int cfs_rq_h_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && (cfs_rq->throttled == CFS_THROTTLED);
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6011,7 +6041,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
 	 */
-	cfs_rq->throttled = 1;
+	cfs_rq->throttled = CFS_THROTTLED;
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
 	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
@@ -6028,7 +6058,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
-	cfs_rq->throttled = 0;
+	cfs_rq->throttled = CFS_UNTHROTTLED;
 
 	update_rq_clock(rq);
 
@@ -6080,7 +6110,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
+		if (cfs_rq_h_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 	}
 
@@ -6098,7 +6128,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_idle += idle_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
+		if (cfs_rq_h_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 	}
 
@@ -6503,7 +6533,7 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	 * it's possible for a throttled entity to be forced into a running
 	 * state (e.g. set_curr_task), in this case we're finished.
 	 */
-	if (cfs_rq_throttled(cfs_rq))
+	if (cfs_rq_h_throttled(cfs_rq))
 		return true;
 
 	return throttle_cfs_rq(cfs_rq);
@@ -7029,6 +7059,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int cfs_rq_h_throttled(struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -7310,7 +7345,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			goto enqueue_throttle;
 
 		flags = ENQUEUE_WAKEUP;
@@ -7337,7 +7372,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			h_nr_idle = 1;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			goto enqueue_throttle;
 	}
 
@@ -7431,7 +7466,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			h_nr_idle = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			return 0;
 
 		/* Don't dequeue parent if it has other entities besides us */
@@ -7472,8 +7507,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
+		/* end evaluation on encountering a throttled cfs_rq hierarchy */
+		if (cfs_rq_h_throttled(cfs_rq))
 			return 0;
 	}
 
@@ -13519,7 +13554,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
+	if (cfs_rq_h_throttled(cfs_rq))
 		return;
 
 	if (!throttled_hierarchy(cfs_rq))
@@ -13533,7 +13568,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_h_throttled(cfs_rq))
 			break;
 
 		if (!throttled_hierarchy(cfs_rq))
-- 
2.43.0

