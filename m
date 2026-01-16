Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915F25EF9C
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596453; cv=fail; b=CkRKfHVy0rb4LKVW393aw2RpnETdVAI/NF3ouTiNKT29BW1HFu74ZfkCXmtsxVHq7hFTHK7liB1+vIB42SYE8I6Zw9BiFudfJxinextWkbOHLNNus0URKoQxFjTuFqBS/Me7yr9gLEfHn6DRNPYzjJ89DZL8GTwQpVp94e6uX7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596453; c=relaxed/simple;
	bh=X3IoRqmrchlDXzEfNWBxfMlKKGYvvZeW3xDKJThOlWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M//q8ChqNQJpUS2GxfSwqB9a66llM4yysi7axVX+f/YuL0PXEzqIqH1d1xF27NcpAgzM0X+QoKCrBWyAkK/O/lo/JIgMAuHi/syRSQ1bLaUWY7eqMWlXWG15ug7JtboQEOZulgD+46pl/6qY6eWFvD39sa7hB1u4bVZW9ujBmfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqtNuR8p; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqtNuR8p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9gtOPbSrdrDTactcV2b5ZduYYSYNvuCf8QoiqNxaN4flxyqWcNFpu4FgXcAx+QF4QULvdCMI/aiI0aS3W29Ecom9aGrrv2DhqKG476nyteuK96UudmJpcuRmMynv0ko+m7ChONEGNU5NfZvYfi+o8x+v42kL5idZQmPakVRLO5s/W3gMo+3UKw5/ztakyG1ggZjWMG7AR+leI1nOOhFA6Fy4TGx9IV97mW3ydjEAhTecbbYnqjpZW7UGjiVUM9R+MvUQ0cyocrUQX68DvqwtnP/+UYqFXjrKR27r2dui5EIK0AuMA0Rymet0ByjMpI2zArNckx8MlST/gW9YvCwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ2vRG00rGFN2TQlg/lihRFa3OdD6pK0B8tWbrLT2HY=;
 b=YsYLeJZym1qBxrl9caOjb71zrffFiuOD0AZ0WgtU8sC6gwLyFwrBlA3QQ+WlvRZA4MB73yL9LMU5c3VUL8Lj/qXH97Yo0AXB+y9+VyCPwTOv5c+H1fuMUgVzPHZbff9ScIyu16hdMbiM+hSW8GFfrpaZEZexoJfaqqghq5oD9o+BCiFRnk4vzHyaRBG23mb1ExAumvGqRyqmvI+/rNaRCNIFS2Lt2QI2vMoIjRxBkQBn/QMAUJglFZ3swyKe/iJLpZNVFMOrXQtZnJxT/Uj+zxjsRfom88RLWOhLg5bEEXZYubgLp/iHOnNGVy7aZBdB0l3fLmBLQZFBY9zicYZXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ2vRG00rGFN2TQlg/lihRFa3OdD6pK0B8tWbrLT2HY=;
 b=qqtNuR8p5ZeEQOleyju2+JZZ2tQm29zHUrgcqceqa8NG2RZTvZFmGyfuejPJUpID5erUdC6uDJWeC4WtUt/UcB6ufbYFtCxLmwwbZQysT7fNEh9+HUQxryfZkphD2kcN7XXlHu+Twwkni2w73HG8kliRm1+IKPMAdaxKGkuQLu3iePyAwLoKhN88f2wnpkOdmDQ2oiwh1u8LmOT/o7kVNjVP6UbO5cd7zyNfhgUmO/l5jNY6U8Vqq4lBcG5Z/XcmOTIkRLoT2RTxNTSVaYLIwZ6UajFNIiqEAQs2WEUWXpVsFLHA0xt9yw67AFQKAiEifC46l3X6DBbrOrfhSrCpyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 16 Jan
 2026 20:47:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 20:47:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 3/3] mm: add + use vma_is_stabilised(),
 vma_assert_stabilised() helpers
Date: Fri, 16 Jan 2026 15:47:23 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <F2B8BED7-E2A9-4D0C-BCDC-5B83CC58302A@nvidia.com>
In-Reply-To: <87b36e11c632fee6c965b944974d8dc4357b5904.1768569863.git.lorenzo.stoakes@oracle.com>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <87b36e11c632fee6c965b944974d8dc4357b5904.1768569863.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 19be061f-447e-4261-0cc5-08de55407665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9VmvgRRqolXp6ki4U9FOHtZuypgsMAn6sDE8baQ1sPYsHJPbk+zWu1nz9cn?=
 =?us-ascii?Q?bkKUEyzB+WbZrBwLc3aX6a7a7KefOZqEhxRb0F46DkDJ+SAfwdRQtPhiLCBb?=
 =?us-ascii?Q?7mhOGxZ62sKvxCCqjgQ04TKajgRqulVxQ9YkAP2420SWCED/7tdKfh3+7eoy?=
 =?us-ascii?Q?IF3cRnPAZxO4O+Tii848bM5lDkz3iHEeuQOobqe1oHUSY6NUcgt3Ile8ZAgb?=
 =?us-ascii?Q?wMXyfXsbQaiOVbpStj1FOcWTAdSWIKrMWprvVI62VXfnwDhQ2yh8P42XtBTf?=
 =?us-ascii?Q?kNz7XnkZMq3HVmGdyfvP55Rda7SU+UgbPshTBA2DWWgXQCwOWwbBltZOF7j4?=
 =?us-ascii?Q?PxjsRkZO1q1hxfCtrdThQmG6yE6WDd/efoizJ1t4oSIokUZslbYkXUDM8fJn?=
 =?us-ascii?Q?sw+ZcEhsj/VlSBIpltqT2ROy7ReeWOiVeoBzS27i3egzRftpByQ5SnWOC63F?=
 =?us-ascii?Q?EHjBGqQ+f3DThELW/J9e5dj1GmEeTdFNkhggmcJCpjN+7hhRxhe4TyBcXoZY?=
 =?us-ascii?Q?6HdnJjQwr4VzoWQ4s7H2u9hqJo2+vtLa7RVoGpPxyUXAUXJ1Sh8Af3RI3sB7?=
 =?us-ascii?Q?ytPvusqbHOBnKxAdLWe1WLt3OZtdV0JVgMA9j1pJwF3uSIW8WQ+hWElZR55H?=
 =?us-ascii?Q?yjNgDoTHlMsY/xLH8fXdMAEkNvBgyz0AK9sb5/4t06PFuanLJJa+EItCVL6j?=
 =?us-ascii?Q?uZ5V5vvTYBxCd/OZElxPmHDN1XEyOupQVVtpeubySjc6XydgMN7zc4UovC0h?=
 =?us-ascii?Q?u+h62H+YU2QXSIWjO4Y6RAhA9BudQXxC/tjnEPxFMgfhMCrXEURIzVSwD2Tj?=
 =?us-ascii?Q?4f2k0ZqXibT0YDSEk16cx1P05R40ebYKv3C/IDLmw4tLu4Bm+2H99S3qzdFU?=
 =?us-ascii?Q?mDS4vbXoH/KpWZDRfmzYh0M5LsIpua1Xwz1jIDGs6tr8MuFC4FYzZ+afmi6B?=
 =?us-ascii?Q?digWOcZNkOsVwLQJX4Ht6ALDrMn2cYxB+/Hnn/WYfTY4exW6l+yZ/0FK6wok?=
 =?us-ascii?Q?wXyUytVIKaBb6bA5VDRqe2tvhlg+3uwYMQHGGNCunfmcyfYGeuCRPMPPO+kI?=
 =?us-ascii?Q?efH+iv+PanXurntKEd2WsAmjtbLXQW8cnUsjS6QfeN0KZ9Yj92fJZjKNNPvk?=
 =?us-ascii?Q?36QTBVlsMhEQzMmD4a0ZB4gB83e9fXV0LzZiBZBoku8kDXbnlojXcg1Mh6wB?=
 =?us-ascii?Q?ndAb4iTpmZqW5K2LR2asCIlEM+B8tJ/BLnwea+0ufZphyniQ06DMDaxI/Dzk?=
 =?us-ascii?Q?4S4vwQgIPRfS+NJXOP7rzi/YEbJmY1ZcA4GvIGXe8TieUj7z5fa3x/e7nvvX?=
 =?us-ascii?Q?bKmjK6Dkp+wQzOy1JWpiP8hc+IJYvOtdyl2QrOsEt56xlZIjTFFrgLwnfHpg?=
 =?us-ascii?Q?6rRf15BKugCtaFrGokN863wAUNEZebj3sz4ZFtiUfHwA0tcBOFrSf0VHQVKB?=
 =?us-ascii?Q?5YorNoeE64aLKbcnxzCJXAVWSaAN9c0JSEy93fbcPfWAeM2s4EObLA6hzZyq?=
 =?us-ascii?Q?KtJuw7hcAGnMiCWntrv3iHROanTcqgMs1Bn9ISVQXN38xuisWlXwuXsTB2l7?=
 =?us-ascii?Q?ooGPIl+DzkQitFYDRvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDvxIsWC3bE3HFr9TiZo2FSdOG/G1sOPWWzOIbn9zolYzIdEDLf/H3lNnYnV?=
 =?us-ascii?Q?LSKkOQLQg4sR/tmu4M1UTQ+ccWHimx7asGhdG2Jf9CXv0r5WtqIp/E/4cewP?=
 =?us-ascii?Q?lD4G7scoIRw5GBuuLVR0gd5IU7tSHlBnRKFqxhZ1YSgVI+WB3REpusOQzT2C?=
 =?us-ascii?Q?/NgPX0WLer2jevtIHz7MRjQ94QnTH/In3fmE/6mCAfdB8swTff+3c6H12cOh?=
 =?us-ascii?Q?k85gOg56CofBRAG1pxej9Jl8kxAcE+TkpiG4t2nC8WnCmkp9mzQlejlHGQ30?=
 =?us-ascii?Q?pPblXGB17RG2ISBYexDt4gIEsOZT6mWKfd0SZijUUXDGc+hnrGTucNeBte7t?=
 =?us-ascii?Q?OOw18PeRM6FbaWyOelaPxFoLSoQ+heNWcLx6fZpK+pogR9jEeGKQSwufOMbo?=
 =?us-ascii?Q?fAXAJDw4yJT6kR3YqS60n65dW5hLDasoGVi7FUobjskWDX4R6C/P+q5ya4Vg?=
 =?us-ascii?Q?wj4GJ4wOeSTGcdeRbKP9BhmwDXo5xh64A6IiwPMsmQrowLvrbPktMzhyDhEo?=
 =?us-ascii?Q?g1iS/JmIjPGCjyUmTtIR8td78czetdjA9nXrdGHkKTQ9ce7HFX698u+Wl1dw?=
 =?us-ascii?Q?NYGYPRUAaNM8TrMTZsRutrjCZOKJ7nc1XsxZT3j3KwY2xFpMPRH8RjhtsQBI?=
 =?us-ascii?Q?YcovBy5mJz526I6TPWpAu1BbDjmRapp12YsS91TK7yz5tDUfo2jMS6VSX/Ht?=
 =?us-ascii?Q?8CjBfXeQic6FRuBJc+8lSGfQihiboIVSpPEjHnfhAfPnTij1RO5RGvsetHWI?=
 =?us-ascii?Q?Sqcj2HK3dCNtzfKoZ8ryxBbSSwSLAYH5bqOcl0cR8UoYbK8QAfpQ+0Ydm88Z?=
 =?us-ascii?Q?JJNc+S1dcik5PbM4qGCT5OgP7h6C1rTyRbp88EBXlkqW059xP0hO3ciJUaGU?=
 =?us-ascii?Q?tMiXfdIjekjpqC/ktVqPGyuZxyqNZwY5CPiwxvRomMlbcnZkCT503Jn81C3F?=
 =?us-ascii?Q?4YF/0xfdAjWqPUIm9KEUa5ltpBSmjy9NQBfnj8oOMjrmrE7akpRbLgLSpuPA?=
 =?us-ascii?Q?Mm1FaWjPhGNe9HgcwgtegP5nYZBwTsbYWzz1nFT82hcTdxeSOPVEiQYYMu5z?=
 =?us-ascii?Q?G/nYdQcK8aR5wOEnmHCSYD95QGCIuheBBFjJDVKhDtvujgXxL9uFDnS4v8Ry?=
 =?us-ascii?Q?UgXF4GDgFQ4kzWxSXbsz5QeA1JQ4lTNSfQ3KTGYtBWK8cO/P4RtTB+v4WZXY?=
 =?us-ascii?Q?opvK7QMw4GCLT1U36QYcTmljKqkGbWTR6XghJ2aWd9eWxwYq4nut6pOoXxgm?=
 =?us-ascii?Q?BGSLjpL76rhX07fMbW1oRnTlVHP2DZBzolsa7gkw4G4xT+2GZM/N6Gc4As2/?=
 =?us-ascii?Q?9PmY753t4f2c1EGQcbRdTIgJLhDNvHpMdzmocn4jLwXiC8EueKtWpIt/ajPF?=
 =?us-ascii?Q?Ik4cJzvvCcz+i4svtuY/FgNW4kxAxpFId257W6Jzz7PcULWd3Aucwklou7g3?=
 =?us-ascii?Q?gqEV4rtgLXtHcsk4wqtprzCb7XjDs10jf7twzv1cMvyVwwQRFPwmX9JnLNVT?=
 =?us-ascii?Q?xvjE6GwCBKYiPMUzJzipDDP8XJQPxXlVcXYQ+yih0umU218RZbq8B/ouET8q?=
 =?us-ascii?Q?slf52hnkjU8fOZ+9pEvIYw2L8yNZm/IaZPWLOf+wrVqRUxIreG3WY7b4vKvj?=
 =?us-ascii?Q?/CwxhXOT8vvniXnt8jJm4xTfjnOVudWOcsDD1bmxrwy1/aXA4uPlmsTEF7eF?=
 =?us-ascii?Q?v+lGXWuqEoi8A82KnpJqLkiTB0/x8Ft1F3yvl/k//q8Q0d1w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19be061f-447e-4261-0cc5-08de55407665
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:47:28.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIwJ3CncNvuSFfnoiYDr0tHmiLt8miizWLQyL4z2z3RkkqI+ElCWk3Nv+Sj/7DRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA

Reply again using the right email. Sorry for the noise.

On 16 Jan 2026, at 8:36, Lorenzo Stoakes wrote:

> Sometimes we wish to assert that a VMA is stable, that is - the VMA can=
not
> be changed underneath us. This will be the case if EITHER the VMA lock =
or
> the mmap lock is held.
>
> In order to be able to do so this patch adds a vma_is_stabilised()
> predicate.
>
> We specify this differently based on whether CONFIG_PER_VMA_LOCK is
> specified - if it is then naturally we check both whether a VMA lock is=

> held or an mmap lock held, otherwise we need only check the mmap lock.
>
> Note that we only trigger the assert is CONFIG_DEBUG_VM is set, as havi=
ng
> this lock unset would indicate a programmatic error, so a release kerne=
l
> runtime assert doesn't make much sense.
>
> There are a couple places in the kernel where we already do this check =
-
> the anon_vma_name() helper in mm/madvise.c and vma_flag_set_atomic() in=

> include/linux/mm.h, which we update to use vma_assert_stabilised().
>
> These were in fact implemented incorrectly - if neither the mmap lock n=
or
> the VMA lock were held, these asserts did not fire.
>
> However since these asserts are debug-only, and a large number of test
> configurations will have CONFIG_PER_VMA_LOCK set, it has likely had no
> real-world impact.
>
> This change corrects this mistake at any rate.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h        |  4 +---
>  include/linux/mmap_lock.h | 23 ++++++++++++++++++++++-
>  mm/madvise.c              |  4 +---
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 44a2a9c0a92f..8707059f4d37 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1008,9 +1008,7 @@ static inline void vma_flag_set_atomic(struct vm_=
area_struct *vma,
>  {
>  	unsigned long *bitmap =3D ACCESS_PRIVATE(&vma->flags, __vma_flags);
>
> -	/* mmap read lock/VMA read lock must be held. */
> -	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> -		vma_assert_locked(vma);

Ideally, this should have been converted to use mmap_is_locked(vma->vm_mm=
)
in Patch 2. But this is a bug fix here, so that churn is not necessary.

> +	vma_assert_stabilised(vma);
>
>  	if (__vma_flag_atomic_valid(vma, bit))
>  		set_bit((__force int)bit, bitmap);
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 9f6932ffaaa0..711885cb5372 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -66,7 +66,6 @@ static inline void __mmap_lock_trace_released(struct =
mm_struct *mm, bool write)
>
>  #endif /* CONFIG_TRACING */
>
> -
>  static inline bool mmap_lock_is_contended(struct mm_struct *mm)
>  {
>  	return rwsem_is_contended(&mm->mmap_lock);
> @@ -272,6 +271,11 @@ static inline bool vma_is_locked(struct vm_area_st=
ruct *vma)
>  	return vma_is_read_locked(vma) || vma_is_write_locked(vma);
>  }
>
> +static inline bool vma_is_stabilised(struct vm_area_struct *vma)
> +{
> +	return vma_is_locked(vma) || mmap_is_locked(vma->vm_mm);
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)=

>  {
>  	VM_BUG_ON_VMA(!vma_is_write_locked(vma), vma);
> @@ -358,6 +362,11 @@ static inline struct vm_area_struct *lock_vma_unde=
r_rcu(struct mm_struct *mm,
>  	return NULL;
>  }
>
> +static inline bool vma_is_stabilised(struct vm_area_struct *vma)
> +{
> +	return mmap_is_locked(vma->vm_mm);
> +}
> +
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> @@ -463,4 +472,16 @@ static inline void mmap_read_unlock_non_owner(stru=
ct mm_struct *mm)
>  	up_read_non_owner(&mm->mmap_lock);
>  }
>
> +/**
> + * vma_assert_stabilised() - assert that this VMA cannot be changed fr=
om
> + * underneath us either by having a VMA or mmap lock held.
> + * @vma: The VMA whose stability we wish to assess.
> + *
> + * Note that this will only trigger an assert if CONFIG_DEBUG_VM is se=
t.
> + */
> +static inline void vma_assert_stabilised(struct vm_area_struct *vma)
> +{
> +	VM_BUG_ON_VMA(!vma_is_stabilised(vma), vma);
> +}
> +
>  #endif /* _LINUX_MMAP_LOCK_H */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4bf4c8c38fd3..1f3040688f04 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -109,9 +109,7 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> -		vma_assert_locked(vma);
> -
> +	vma_assert_stabilised(vma);
>  	return vma->anon_name;
>  }
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
