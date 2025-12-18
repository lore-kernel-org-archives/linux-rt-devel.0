Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88463333759
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052539; cv=fail; b=Pp+ZDajIn1cVfQeXZh8EiEaPOWxLUbq/sSFW7cNAbIv473fBmDm96b86QTaU+2APE5L4osAwtvp8Rou793ToDNeW8tQkWAId8LGe/a5dTjNtOpRCPpn32b84790DjmK/xQwMKxd2l+aqL9uR1WMdTQdAQriRbIuXe/+qo1EbUC8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052539; c=relaxed/simple;
	bh=82GkpJRM+/JM3GL94PtEeBYOk5i74pjeGKNzAGIJqPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zd4En3X5SrU4jkddi3iV75bWIr1Kcj2dPaLar2eJ4d4tPwXuMuacrIEuk4i8Hjlw0FXSS3BQBT0jg3LCz9NtdrZY6fHrW/vnA1tChQJVhpUMBhyPyyBdKBvvcDmiI2vzqckXTYA4xk1YSpEG9IxCe37sEpfjQQN5rOq8ku4pgwk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K8fAOZus; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K8fAOZus; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K8fAOZus";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K8fAOZus"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VaikZdGgG8k/cn3WSvbtBVqhpoSXmEzoCnbnLR6HHKEWfef9xLGB1A0ckR7RL+Sxv7ODyrL0EU/c/E1IroaHT69rnmLjdi+dncgSshu0wZuNnh0oK7nniwVkJwIw/ixTWSEnJvycskFOLk5Mc6XUFI02Pg4qgYbQSXEySnTYpMfofvmUzFskT6+thXM9FuU7epvpeJzx6OclvVGK59fZKFO+gOP0wkYb3mY5X+LVd4KZ5p5wk+CjAX3dBLl5h73yq6JQfSuoSQ18JPEqngFLK8fkuHvj+7hTzNqTJ7yiXWwhKIdGLbq3i1gGX7r2e8S14/eB8yejUgUrciQVTD39Aw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7wu7mnRkaK5fFPeUNNgYoL2gG48FfL+uT8KLU4wlXE=;
 b=UgWyeWXERO4H9DIpEMHqSkkyVpIPwhAPm6v+9EUwTGIaO6oYY12m0DrELd7Fw7MGBEu65DSBJsQYtM/O768ROhs00XYSFfmXqkYtZsWIKI8PI3cAxd9G6nC3HwLg+hCmDj2r/+uvMHCEnT6DKm04KpCUZcluNUMkTPjcN9EO5EUhefzR5lZMp2M2DCm6+NrE5/ITHM+sUZ0u9ezfIU+G5Eqr8ELa5RKuxMEQc0yz1xqooqPJh/xaes3XnNxcYxQYOFiges7H/nu3dkXiRpkyBZn/lPlg+7QVdyeusf8AGe4gyn2zsL36/Rnu4I9t1rDDw3MmwGqHK2c64GhgXfKk8Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7wu7mnRkaK5fFPeUNNgYoL2gG48FfL+uT8KLU4wlXE=;
 b=K8fAOZush3Jx9DQKRb4N+eOpKIsV7TxsxRigw2CErG9sEormRddg1oM7idNgu7iRMyycQ0mlwEZKtrUUgnoYZ5OlNXe4XiAFd/e9BUvLEdJ0AMtbfZP+YeP2x5hS6Qv/Uxpy2NCoYKjIOu3RBphKT7e7QYy0/YrP8llIEsUeDt0=
Received: from DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) by VE1PR08MB5583.eurprd08.prod.outlook.com
 (2603:10a6:800:1ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 10:08:49 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::fc) by DUZPR01CA0067.outlook.office365.com
 (2603:10a6:10:3c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 10:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Thu, 18 Dec 2025 10:08:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5YCvGOlRsRn5cCxDAIyQJ6jeD8arPSbMEG5JbtnauTofK84tVlPUwfTLF7rKmqV2ruJurJa/3Vo0lVFq4qkfBapNjrIFxI1JMZjzhDgJgXXRnmiS8ICVbMS8erlrE8KT343SNSCThcTzgf9tgRlbY8JXQIDUV+6G1AD+Le0H3bzNwCzLExifoVhqS19moJ/JJk/BMxygLt5EKnGb43xVa4PJcRBsBksgM7Sp7rohRhjMmFzhy8KOuIGxpoXmci0ZPwyB/IhPGhj2uH+AhErpyR0zNe5zlgDQN9+mB1fTl9TBEJnr6WN72kZnc6u2nLKBmEpQhZDyb863+Ukx5QM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7wu7mnRkaK5fFPeUNNgYoL2gG48FfL+uT8KLU4wlXE=;
 b=xJB7b45Beqf+6VEazxXhzUpDs9zAjZxeel4uYeAq+jaqJWZqH3a6M6zsl7lpBBb2bzVUfJyLOvTUsvWE60Fly12rucDaIGyzoALHCOJEhP5C/c8fIWIwbo72UQ4UJp+jEtldlHH/71INWn30pLz+VR3nOyBW+PQjxcp5siWT5A79YrVyiWtICCF/7YD9rydowcV2nlbjDjEjNJMxO4DHqpbjbaW8+kGaGdGzTSQxnsOFwog7R0eyOaV35tm/8jnyxbuqaUwpwd1eJaxKjclB0Dbh9DgOAFFt/kGMADCk73kz2gL0T1KhozZ/UlwmNfAdHe0WzYEDVoc5g8ko800J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7wu7mnRkaK5fFPeUNNgYoL2gG48FfL+uT8KLU4wlXE=;
 b=K8fAOZush3Jx9DQKRb4N+eOpKIsV7TxsxRigw2CErG9sEormRddg1oM7idNgu7iRMyycQ0mlwEZKtrUUgnoYZ5OlNXe4XiAFd/e9BUvLEdJ0AMtbfZP+YeP2x5hS6Qv/Uxpy2NCoYKjIOu3RBphKT7e7QYy0/YrP8llIEsUeDt0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10751.eurprd08.prod.outlook.com
 (2603:10a6:150:166::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:07:44 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:07:42 +0000
Date: Thu, 18 Dec 2025 10:07:39 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
	will@kernel.org, akpm@linux-foundation.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Message-ID: <aUPSa67xnQk/x56R@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
 <aUL/zJlJFRz2/Ybt@e129823.arm.com>
 <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
 <aUO9M/oN+nx3nfW+@e129823.arm.com>
 <201d0fa3-2ebe-4df2-926c-9e11607a6f07@kernel.org>
 <aUPJ1N99LEVZ77co@e129823.arm.com>
 <10ad7480-4e8a-43c1-9e18-db72e63dbe98@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ad7480-4e8a-43c1-9e18-db72e63dbe98@kernel.org>
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10751:EE_|DB1PEPF00039232:EE_|VE1PR08MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 011caa38-cf88-486a-31de-08de3e1d6f94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?v1vAhCSIZ5rGIRZUo99Dm9ikmiqN1s7RnhVY0AZi0zjT5mnzC5CMshbloaFR?=
 =?us-ascii?Q?DClql8Sj6D9IWhfAoJRfKiRivroxJsZeYMBj5IXlnNStJ/gKvtBm8/fpUnWW?=
 =?us-ascii?Q?t3WO+2hBy458Sw20cRM9LhnPl5aaXLy5r+fGi4kl7M/tOBKHDvVa6dxzOgex?=
 =?us-ascii?Q?Q6nsQ0A5miQSn7u/Pq8dSTqCxLYMJNIk7BAy+7tE0D5oKeGQoUGAHaGMJ7zN?=
 =?us-ascii?Q?g5Ky7RrkbMppn2CjkOoJjRRmJxKSiWrmoLrcUyqHUYhIf3bTvdKVS4ls0zo8?=
 =?us-ascii?Q?qRtmUn8KogIqQYbS9R+14zfhuhN7jUBZngkSYS9pUZRemsVobpPhMP6+O9uj?=
 =?us-ascii?Q?KlvzZZolr+eoQzZuryLGB3QscWHnbp5KEXCeyre5tEsnuAGwt9+I5kV7V539?=
 =?us-ascii?Q?ko6USbuezhGPGuaT+aAOXtytUOm5HvUD3764X9nmGfSiWnQOxIJKZiCpnhVq?=
 =?us-ascii?Q?Za0W5RDDSvppLzomenK1VwyduLyJGVhuMIEI5N5RF6tsljrFrL/NnzrBXnuv?=
 =?us-ascii?Q?ApwfyYeX+IPl+rt50dfEuOF3/aonZzN7qLWLlfKDtxhxEL9sIKTOtvCgqc1E?=
 =?us-ascii?Q?gifoe50ZWRbO6EKkZgEQjmQ/KYiE74ZOJuKWzonL+YNUdBRI7eq/F4kFsgOT?=
 =?us-ascii?Q?USdcBiMXcW6X3adTd730KofS/EJIhA3JOo6hIoMtkqTMQw5z0VzTyuPFZWM8?=
 =?us-ascii?Q?7TLyttuhA29saX9gsTrUZJuX02goooel0KuTj2RyHwjDEQdRzT5JX/SM1vch?=
 =?us-ascii?Q?NnTuZ0//T/g46tQmLGe6E7uMhgXe7hjdWPNVXnYBoo1Z+sh7yBce+TGR3z8l?=
 =?us-ascii?Q?W0IKk7AHiQjkMzmcwtWY0sxQJLQeLNikLGLP7/nqfUOVmrABIy343oq94MBQ?=
 =?us-ascii?Q?2KUJy7TSqEvNVtbvurpotncu4lSJV3SS8n+TfTXqV1XgUL4JbintF8TNWTZf?=
 =?us-ascii?Q?T8w6dWwhokVzN2zt0eYOOQSaPE36Y6za0HUIQ+oRhtnZLqXTE4GHbnl0hwgA?=
 =?us-ascii?Q?07x3SZRRSs3/4web5NJlQn8ZDJFRl1ksaPgNP96EzlVo1PbsuusJGYUJJ7AX?=
 =?us-ascii?Q?KPMuFORz31sPKA7hg8068skziXrIg5EdIB4Ko8cRpZ5p+EOwh8SL6mCQu8ar?=
 =?us-ascii?Q?hYuD6Smt2wZhvztcRE9bd2oTMUdhZXLUSx8WzI53t3FFmV+ZzsJowm7muQmM?=
 =?us-ascii?Q?SmRRYsFOttlySOvCm2Hqb7j2qIGmd2zy6JN4MQtQ5F0vlFTwu98A/DoosF46?=
 =?us-ascii?Q?bcYdZLTSvfnsmPYA/Zn1VLwjEeYjAsE7oiT1peT1ir0z61c8y4XXi42V9/9E?=
 =?us-ascii?Q?8sMjjLzcU2dz5MWNFyxQ4JdBQU1acEbEXD5BzHfWVAHj0Eis6ZIt52zmoND6?=
 =?us-ascii?Q?E0yWfqd1EvftdAW0ctxEjgconP+awRNCuKNyaJmRJFIGGm6WAU1808ZHLOej?=
 =?us-ascii?Q?nFqLhfsEbdmK4m3X9Bfo0DA2Avo9tc2B?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10751
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	76db99c2-de12-4078-5590-08de3e1d4880
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yep/F9cDIVvt+P7HqkLBuZLQ7GJS0NJrLZk6kQCaVxPX2GQ5/Xl6zDpJdkAk?=
 =?us-ascii?Q?8+H0gyVlnU1F2EPZk/QbI2XPL+pfuGa4sgU+glIYFNScuhMmHYgX1s2DwANb?=
 =?us-ascii?Q?kKuJO+kREQaDu+AcTf4cC+vwj9r7IJz7NN4Nl8Sa5/aLVDjBklm2qMvnr6xK?=
 =?us-ascii?Q?vWNVZcn2uTeXR9YO3i9NDMazHoYRYCRzaBnbU+Dp76mcrB/a7I/6k01QBADK?=
 =?us-ascii?Q?9/89rpNPjJJyUNg3Xa4KvsRPJhwqG/LhYte7X9N0HQGvCXRY4zIaOIj7nCX+?=
 =?us-ascii?Q?Y4OFk+Nta1t2YjmkvXfa7p3k3ikVS4T79QvFetpelcI163j05HMZ6ptjWROM?=
 =?us-ascii?Q?NWCp4JMPSQ/z/5fIZet+6dpK9vo4xlXxmBoVxAqFRROVDGd70YfsQatP1FnU?=
 =?us-ascii?Q?G+1lNJApok5SULM2SuBSIY00OUbfEHg6UoxRCA604/X0BbqWOxtzroekm4dl?=
 =?us-ascii?Q?WGW/Hh2jdPkr0MM3s2SjLtYMhA3PNNgaz88GlPLD/G6W9LBYhB5oZwMoosps?=
 =?us-ascii?Q?zZRrOp7Zn9sDivWuu+0YvoZxaCrZAitMommouBJmGiB9OfrS3dVbq6GlT2HJ?=
 =?us-ascii?Q?AaPhDe082oAx1Ln1FN+KDjnKtEpJmX84f5ov3Rnis98DY3fq1DUcw3usVBIX?=
 =?us-ascii?Q?Z4XvMv+bSXA+DyHobugdd7zVNcrjWpsoR9sSZz39O9Pe+1ckLYrb9hHHfUe1?=
 =?us-ascii?Q?TEE67+CSbAMioUckkCjaaiWJepT+f5K8w9K9K8diBGu8E0GlQI4RsEKuyna1?=
 =?us-ascii?Q?xE2gDaranUzRY3nbrXAtyNo5OA4RVn6ZnQtq+vttIvhbbcBbMVr89JeiUeph?=
 =?us-ascii?Q?v2FSweMDN9zni9HlKMW6yR1xpPdP0l1/rjLicdiPI/incb05qbNCpWowJMnf?=
 =?us-ascii?Q?+oL4q/Fq8FO0PffBsD31M5KN9UK7TidnQCpbhZ5iAAxs43mRqgXkT7SRabjA?=
 =?us-ascii?Q?/1ORLpL/1uY4t00SS1HrHKd9gkqXWePiCZrlLAF0aZHOfR1Rolxv4xDOgCfe?=
 =?us-ascii?Q?lPkZqlioRy+i5WuMo3eRwMk33/1WIWLbroerEE2CmhBenHgCytOEfWCj0M9t?=
 =?us-ascii?Q?vvt5vPqYyFCy8QZOPJasAAO8FbXbxl8VZLsQ5w7m2vHE6JQxpRI/xpXznsTE?=
 =?us-ascii?Q?qRrVftOONVwkUzo5LD9Q4CBM0hyTktNBNEyhTiHvJLmUCA2e/gbPC3Dfc3N3?=
 =?us-ascii?Q?IL0iLDOBkKA9m3buIJ7AS9heuNmqMQlE81e3P8KJ7Uy9o4nsHk38EB60i4sA?=
 =?us-ascii?Q?mhXP3/rAzvQuo7RLd6aAC/2XZex7uQbgPRifF+88AOSblrCKlConrVZ8MOmy?=
 =?us-ascii?Q?Hqr+K3On9X4gcBzia3OVPIjuayJXPfBwwjhhQt2i2TmczJrRC3TjBEQ5qKEV?=
 =?us-ascii?Q?LCMF6EuFteLYRhQIeiZVBewhyNM2NTRRNNZdWrfCW94nuJnhKJc+DrQstWUO?=
 =?us-ascii?Q?5+mvqXUMvvuYVDuZ6t1ZeCn+LsAQ/PM2XlyjMpR3J6XfL+rN9V2ViqszzDPK?=
 =?us-ascii?Q?sGbXfDlgBwcu3Qj3kQ4fFkldt+eVb8ohZlw3VVy8EgQZjqcF+0GXYNf+qPET?=
 =?us-ascii?Q?j7W/SBoChzYebo90D4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:08:47.9166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011caa38-cf88-486a-31de-08de3e1d6f94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5583

Hi David,

> On 12/18/25 10:31, Yeoreum Yun wrote:
> > Hi David,
> >
> > > On 12/18/25 09:37, Yeoreum Yun wrote:
> > > > [...]
> > > > > > I think it would be better to use only __GFP_HIGH in here since
> > > > > > when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
> > > > > > and to allocate page with assurance, It would be good to use
> > > > > > min_reserved to.
> > > > > >
> > > > > > Am I missing something?
> > > > >
> > > > > Personally I think we should just use "GFP_KERNEL | __GFP_ZERO". Anything else
> > > > > would make this allocation look special, which it is not. If we fail to allocate
> > > > > at this point in boot, we have bigger problems.
> > > >
> > > > But I'm not sure *HOW effective* to use GFP_KERNEL in here.
> > > > Since it's before the any filesystem inited.
> > > > IOW, in this context, almost there would be no *page cache*
> > > > and I think it seems meaningless to use "GFP_KERNEL" and "direct
> > > > reclaim"
> > > >
> > > > So to get success for allocation, __GFP_HIGH | _GFP_ZERO seems much
> > > > better.
> > >
> > > Unless there is a real reason to confuse readers why this is very special,
> > > just go with "GFP_KERNEL | __GFP_ZERO", really.
> > >
> > > In particular if it doesn't matter in practice? Or does it and we are not
> > > getting your point?
> >
> > My worries was
> >      - kpti_install_ng_mappings() is called while in "smp_init()" which is
> >        before creating the kswapd thread via module_init().
> >        Just wondered whether it allows to call wakeup_kswapd() before
> >        kswapd is created.
>
> The buddy should really be able to deal with that, no?
>
> >
> >      - Similar reason kcompactd too.
>
> Same as well.

Nope. buddy handles them. It was a past :)

>
> We cannot expect alloc API users to know about these hidden details to work
> around them :)
>
> >
> >      - Just wonder how much direct reclaim is effecitve since
> >        when kpti_install_ng_mappings() called before each
> >        filesystem initialised where not much of page cache in usage.
>
> Right, but do you really think we would ever trigger that path?
>
> The default should always be GFP_KERNEL unless we have for very good reason
> special demands.
>
> So, do you think in practice there is real value in NOT using GFP_KERNEL? :)

In the *practical view*. Absoultely NOT
since I don't think it reaches those codes.

Okay. I'll change with GFP_KERNEL | __GFP_ZERO.

Thanks!

--
Sincerely,
Yeoreum Yun
