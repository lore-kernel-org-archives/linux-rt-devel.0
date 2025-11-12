Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEA2C11D5
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Nov 2025 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916015; cv=fail; b=eIgBtcE1yu4ugyr1XOhrnX5SFK+fbT3oF1vuo62FDnMTonhqZxphwKSb4PDNp9u9kPjyWQeBCPFrvHs6K5JZdvDG/yUIaZ5egl91ViyJB93G1gDN/l222tcj7KxW+YOVlntVzvEpDEAm0haF/f+Qh1Aj00i4UvQlDyn5N9W+HgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916015; c=relaxed/simple;
	bh=SCAhPoEOwP30FoLaBSVUKZTz3h38uR4jUuuZSke7Uxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQudckvjZPGu5lhx3H9+DshbdC7t6wnithrjuU5Yv82tEJxo0TItvoWbWIMUgPbl/btNeF8RkDpISdnSbuGAtIYTSjFib1G8Ofi2bwC9mN657ZOXudJiYGXur+eX7aJA6MpeFnLFMuO1sziaeVvKayKMZOb6EcRgoc+Niwl+bAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uQIB8lFG; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uQIB8lFG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEFg3dbs8Vfh0QMAB0rB+RFaBRq20+WunPb5PVAGTd+seI+YjeX73h4lO/XCxKY6XZEkQj5JYPMVgfPns6XKc2r9aNmIWnP2ZJx8AlJvFaNZjmxMFZ9ZNduHZweqo+QpHSy8zzWuWJVqCtaeUecIraOq+dcDLvoUY/7ee6K02yv8iaHq20GJEICIVdHZnds4/pHKSp4KpXQTxZo9khMvRnsxAjWdgYEazmgKzTGwCYmPzcOTGlo+MNTPbCVLkwiO/VlojsMM2qVup+GqAxQcxYsTQ/tNrKovDCuta+RkYvYXYv2PVt9oUYeQJfTfevyfVEpCCyRLmTRwtsFgWHfOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U0KjDKden6CEfpTMOE0jW6qtYKcDN33d0O8J8TXPOg=;
 b=PqkUg6qTcrFnrgFGerUYRjF3oWr+ZAWd6bfACtxigFYoOiO5Ujg4/mTwsOl1doG9qNj/v/xpvIXsZv1QGnZocCrJJ+UHnZspIqtA/SovIFotT44jZNU1pYYraAn1OyoEQ2s9i6BHT8IzLoztATMPwYhITSAGEoW+LcD8s+ecms5E/TDPPZv9RE3bHAHyK1AYKnBrw3a+VwyZSWhqGG3BQuOi/UjZjVRHFbPAyGaTP6D1OIXXGAGekpUwoaWEd+x+ds3/7dYoPg0BSaVCnlCoTEoOW48JENvcpVtJRjJtWbTwVFgbTY3GkhndfGP0m3fVPy49hutg9p7cX81eau5Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U0KjDKden6CEfpTMOE0jW6qtYKcDN33d0O8J8TXPOg=;
 b=uQIB8lFG3s6mUZ98AJzCNiGju3K+I765xWuDz4lyoU3eYNcytwzJY5MhHXgbMS7R1dvEW7rKXbckB6kfMyynfw+maKvPbHJkK0Ld2yqi0FXXe0E/9wpB+JJY61Tye9fC7kY7doutmnm5jKI+mLQ2pciI9vAh4DeGRA+hGVYaYgQ=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 02:53:28 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::8) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 02:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 02:53:28 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 20:53:26 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 20:53:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 20:53:26 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC2rQmj1963711;
	Tue, 11 Nov 2025 20:53:26 -0600
Date: Tue, 11 Nov 2025 20:53:26 -0600
From: Bryan Brattlof <bb@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>,
	Russell King <linux@armlinux.org.uk>, Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/5] ARM: Remaining PREEMPT_RT bits
Message-ID: <20251112025326.d6dyoqcw5r3irpeo@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc98556-4871-4aa3-210c-08de2196a840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndXb1dUZFExWUdXZEVEUFBmTGtha2NkbTNkemEyenJlaGxqQW45bnBpNEp1?=
 =?utf-8?B?dGVJU2sreG1OZHFYa2NxVVp3MVlQT2FLdnRyTDVMdUxFYWpqcys4MDhHTG9N?=
 =?utf-8?B?Z2JlOGdpbDFBeW9vTFpXS1E4WHBMVFJuY1dFbVBobm5vQ2paeWtHdExOeWxa?=
 =?utf-8?B?UzlrZC9sMzYvbzZscC9UOUdQaFdtRUdTNk90NjlwL2lIQmtOYXpuSHlaSkxx?=
 =?utf-8?B?NTI3b01PZUtFa1RON2k0V3NrT3ZXRkZQYW1LU2MycytqOXpRN2xVRTV6anpp?=
 =?utf-8?B?TWVHUjBBbGYrQTV0WmxPYlhYREVJSjB1NHFPVEE5dGVpczVzSnArekVQaSs2?=
 =?utf-8?B?V0NXYTVaS0JLWkZ5U0V4Z0Z0YlZlNVQ3V3hKNXU0dld0NDNyYVVwakx0c0Yy?=
 =?utf-8?B?UldCKythbVJ3dE5RNXFsVU9zR3ZoY1JhZDVoMHF2Y0htbFIyaWxrUEpzSm5n?=
 =?utf-8?B?YWV1SUxOTzNjd0I5V0d6cFZMWml6OGFCM1BDS1NjMk1DQUFQMUFHc3pzbmJP?=
 =?utf-8?B?TUFoUXJTbHd0Z3RBdVlLY3RWaWlDeU5MZ3NRN0RKWWIydkFIUFJEa2g2R05H?=
 =?utf-8?B?RVJudVYwSUh2N2RYMzh2eEZEbk5WSWo4T3BLdkRialZYSDhnSmV0VkxGeVIz?=
 =?utf-8?B?ZDR5eHVTRWxzcHdaTlpmQ2lsRzl5NWd5Titha0pQM0pRekYveU9EVGF0L3JU?=
 =?utf-8?B?cFVpamhuc1YrRjVlYmZwcWpFTXZHbDlpTW5PazFhbzRHRDQ2R0t3ZjNWRit0?=
 =?utf-8?B?bjNjaWdsNFl0bm41ZDJhdUhGY0xJTEFwMXNYcGgrMnhZRFhBTUFvL1NlZTNk?=
 =?utf-8?B?QU1yNFJOR01KcjBjTThEQTI3YXdqWlczWDQ5Q2w4bm9RbVdJYzFTVFBoUEVO?=
 =?utf-8?B?bFRuY1R3SmxVN0lqZlI1Qy9razB1K0RyRmNIeWl5WjYzaEpobXV5ZVBlZlNj?=
 =?utf-8?B?Q20xeEg0dEVvVFd6OHJVYk5BdDFLMjArbVdRblVvaUJQZGtsMk5DSWZncjk2?=
 =?utf-8?B?ZVI5ZjhYeTZBcDV1bTRVaFI2TXU1SkY1WG9uYzdYbDErWTRXbGhFb1NpclJ4?=
 =?utf-8?B?N0ZkNzBrQnJRYk00am1WZEQ2NkZDMi9XaEY2VHQwYmNwKzlvdTFHK2tIVFEx?=
 =?utf-8?B?TS80b2Evbkc2NndGbUIxVTZVNDR4dlhVdDkxcjJ6OEtuc0h6dlJMdEZLQnhG?=
 =?utf-8?B?UkRacUxaTEhWQ2g0enJVaFJIbU9IM1lMQjRxRlBxbmNQTEVwd0xCNDRRMXNG?=
 =?utf-8?B?czlTZDFhbFhsL2hlVlJjTGYwcHFKS2MxZFAwSjJoS2QzSUM1bnF3bHM5UXlk?=
 =?utf-8?B?Qmd0YjF3emx0ZnFycmtKb0xFZEF5VjM1Q3ByM0hGeTVhVFRiM2EyYlI5bzdL?=
 =?utf-8?B?YUpZbWpaNUNSVzVuaGZtQ0thUmZkRS9yZkxOb2ZTd1B2aDJwMlFzVy95aDVJ?=
 =?utf-8?B?Tk1tZVVmWTFWMXJLRHhMK1JZbUNSQzJGTitlVEltVzNhM1orZ0QwSndkY3V0?=
 =?utf-8?B?aTdpbmVMVHBZNFdyYUZuQTY0eDB4dnMvTzBxajFFbVVxbnFpekRBSm9zYmd1?=
 =?utf-8?B?bUpHU3VxenlPRWdLYUoxNkVUT3pYMUNRZjdJakJYNHdJUWFpNURwUm5zbytM?=
 =?utf-8?B?d1ZqWktnTElyaTEzZ1hGSUNIaVlYd0VVMU80d1NRVkxSUGxVLys3TkpJV0hu?=
 =?utf-8?B?bzB2RDh0a3ByTndSUTNjczRoN1pzc2xaSzJxYlYxU1pDbE45NWlLTUk4Ulpo?=
 =?utf-8?B?NTdYTEdoZkY5anFhUHlHeEl6NjZQb1ZEOEx1RTNFZFluRlp6UFdnWWNEUWFQ?=
 =?utf-8?B?ZlRpMVJtWHFpMFJITnhDTU1hVFdFT2pzUDJsRHpwNkFBYW92MStETUNvbCs2?=
 =?utf-8?B?T0NtVDlYaGlKV21hZjRhZmxZOHN4clNSdU1NOFZBM043c1o2eW1hczNBUUxl?=
 =?utf-8?B?MkFoQ3RrdW03bmdXc1QzRUVtMXk3VGlVUkhsanA2NlNrYTVvZHZoWUhmSzZy?=
 =?utf-8?B?VnQ3ZFdCa2ZaTi9VdjdQWkFVelFkYTcwTDc5R1VpNUs1SDRzcG5rM1QwK1VB?=
 =?utf-8?B?UjViZTc1SHp4OWh3aGg3OGRWSWtVb1VWS3ZBaFdoR1ZLY2NZV2RFRmU2eW1Z?=
 =?utf-8?Q?HcLk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 02:53:28.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc98556-4871-4aa3-210c-08de2196a840
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722

On November 10, 2025 thus sayeth Sebastian Andrzej Siewior:
> this is the last batch I have to enable PREEMPT_RT on the ARM
> architecture.
> Last time I posted them there was some discussion about making the
> branch predictor hardening worse. I redid it hoping it improved now and
> does not make it worse.
> 
> Is this okay now?
> 
> v2…v3: https://lore.kernel.org/all/20251103101545.760243-1-bigeasy@linutronix.de
>   - Collected tags.
> 
> v1…v2: https://lore.kernel.org/all/20251029155918.503060-1-bigeasy@linutronix.de
>   - Allow to enable jump-labels on UP. The UP build does not involve
>     stop_machine(). Reworked by Arnd.
> 
>   - Instead of forbidding HAVE_GUP_FAST with HIGHPTE enabled just
>     disable HIGHPTE on PREEMPT_RT. As Arnd explained, HIGHPTE is rarely
>     needed.
> 
>   - Don't let ARCH_SUPPORTS_RT depend on HAVE_POSIX_CPU_TIMERS_TASK_WORK
>     which in turn depends on !KVM. Since KVM has been removed from ARM
>     it is sufficient to unconditionally allow ARCH_SUPPORTS_RT. Noted
>     by Arnd.
> 
> Sebastian Andrzej Siewior (3):
>   ARM: mm: fault: Move harden_branch_predictor() before interrupts are
>     enabled
>   ARM: Disable HIGHPTE on PREEMPT_RT kernels
>   ARM: Allow to enable RT
> 
> Thomas Gleixner (1):
>   ARM: Disable jump-label on PREEMPT_RT
> 
> Yadi.hu (1):
>   ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
> 
>  arch/arm/Kconfig    |  5 +++--
>  arch/arm/mm/fault.c | 16 ++++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)

Thank you Sebastian!

There are quite a few systems which use 32b processors and need 
PREEMPT_RT. Thank you for doing this. 

Acked-by: Bryan Brattlof <bb@ti.com>

~Bryan
