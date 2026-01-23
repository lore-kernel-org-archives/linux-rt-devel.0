Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FC2C1586
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199177; cv=fail; b=ZRs7DO4tWImG6U9Ri5q3SdfgTrziXzsbiimWpJgyP39leiHkyda0aqQpsNm98AzUhWgQq2EvZSW6JxHMZgfc5CvgXO1HYrt/886RTgSbmiJMZ4orbR4wCEvY/zTIHQArSWMo/C7ZoCYGaANcdN39uSLbqhP5IW94/G3G0bLY8fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199177; c=relaxed/simple;
	bh=mN6ZAojSsd64UXWuffEhBPVIpFynHpvvapNl++GhN/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVSkkmJZ/1ovS6wiMu4wVpchu/lJ5bsMNpFGqnD8liSIs6Vq5Y8mPcHLqdb7UFfzHtNdV2Dysj02RMsObANjkGh56I1t377Nptw/LyrjwXF+gDnZfWPfx0B14ikV9B7qQ72/+2tgt1/tY4KdeYjH7eLvFDK1zd9cgNIFeQujQIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GFxCf+Md; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jX5iDp+P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFxCf+Md";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jX5iDp+P"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFT8x51884670;
	Fri, 23 Jan 2026 20:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rG+DIQniu2FnWmI0R8wJeWVi1ymZ9Xl95eZnftbxvCU=; b=
	GFxCf+MdFOfgxHScMIVoDOVxmsWOFK2rCa7GJFcJwBSeRxIhRBaQiXWobGLBMn1E
	fLU2oY8jx0zLUEGdKG6NFFbWrrNtXg5vIRtB4/rO40RbiAwR1LDoXzURZUYwtH/F
	UwUZpl0NCzjEfzn5S1TxWj1UUPMS99vLNfEy9bC/mhoFiuKcEwtpZTI3XUi5j1ny
	eX1Eg6XE80cESyt6gMv21IdaPGKkzBRiqlqeq4fxQ1EDLhMf3xtKmP2r3jIvSj3x
	kZIJCBVLv0tFREnGR4vidOk0qyTUMtXESGhYv6k6QElyXre9ZCGOnlfKl/d82qJZ
	HJeoE0gJZF/nlYLw5Kn7fA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8k2sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NIYFT4015062;
	Fri, 23 Jan 2026 20:12:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4butv0w84j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E04DkL+8ANuGJasipHd+77OuecOqAbYzERnDbhTv2xxvCNrgNDFJGQa3nWadR8rLce/UnDxynBevgeMYf2Zor4v/bYkS1KK+uAp6c2k5N0lI8UU+bKyuYrURAa/tDRTQM1E5vqypmPIQvkr74AL2P7gkEFW03cxOJPFfE/e7ISXb/QH8SskjZH89EVakVektSYipO2DoNMk2Zixqul+JwsykuLP/ejwZYqHjOavznPbFrFgDqEv4vfBTPCzIkCu1XpxeI3b1A5eggbVUuKu9ALSjeQQvhgggFVIo0Tr/g6o5/t9vymywkmErtS8RufF1GMopJIhgjiqtd7ylFr+IHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG+DIQniu2FnWmI0R8wJeWVi1ymZ9Xl95eZnftbxvCU=;
 b=TNctrIpRR4buq5hPe0ScrxaJwQpxhGRvH5tzcz2pGu0fjkZ9Eevlq6+x/dUeLaPMt9PnzdPttLnHzeG1PAqh5lFbl/OVha/1EhtnM8HHCHsON01Ne5RhLFBQyZsUjlj1N05ibi4yfjv2RRu9ufanvEizEwNncXZMdtW3IvbPqB9IeUBvJaqAnMHz20tWnPAp41Wkz0QhBbKhni8OotF+sh6CwE+UwqJyk14W8XDi08LqfvnSbR4rdaubnFxb2n9vofRr6nbL8x8bwxtOL2R0LtGRFUHV9xJKwLSSm5G/qIo+yv5SxC1TIIew4EazEkQmxu92cOt2Rtky4jZXt4skiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG+DIQniu2FnWmI0R8wJeWVi1ymZ9Xl95eZnftbxvCU=;
 b=jX5iDp+PcsHRjc+k0Y6P7/QAwEeaGF9I+UZpNWggOy0ZmtZCW+AyUC7R+HgbtWHCSAthxLBHFsWHwBbjAzG4vDLATtK0xvj0qGJU+lrvllNmUpMNrsdoZTcPoW4Wbbwu28zuo6JQXaihfGABM+Hm/nnhsqncYbAkKA+iMHF0fJc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB6877.namprd10.prod.outlook.com (2603:10b6:208:423::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 20:12:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 20:12:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4 04/10] mm/vma: add+use vma lockdep acquire/release defines
Date: Fri, 23 Jan 2026 20:12:14 +0000
Message-ID: <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 02993707-a3e2-463a-1816-08de5abbbb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNH9e8qhLCxZGDYF6F2uQYZ2LqXxjhWtVY4jMO+yJ+qONwG4/sUkEwVXQWL9?=
 =?us-ascii?Q?pCc1TYVQ3w/TQMA1sQ8+ZA0cXFf7JqAYu2kY7CViNC7+yCV3pzx3mUsGs/y5?=
 =?us-ascii?Q?U/Y6vgXrtEKRnoNYqvL3NNFKj+5YxtIWQloNZtWlt53u0zKAHpE9Sh6ivnNB?=
 =?us-ascii?Q?BjAHn6aRolASakaXp+xAj7h5GGooCwpMi/wdvTK3QQUTbU2Loqy481G1JGhn?=
 =?us-ascii?Q?DIdjELbKi5CUnFBjHVRfA0+DpxGOU25/xtusO7ZusyM1CX9pCxCOzzQQJpx0?=
 =?us-ascii?Q?1A8o+UQPGoAlWQSxQShyLgybu2paGZXFil3U0sATrt1YI8Qh0gguA4BdMkv4?=
 =?us-ascii?Q?YNE5PE21qxAqbAmm06hDM0U9nAnrNqd3Ex0/4QwiScqtLgPgcYO9f7opRw1J?=
 =?us-ascii?Q?+Bw5lC30QzmU1eHu3/ZcwQOb1DIbCz0H6yX7IfGM8P4LKSRk/Ct9ZGwX2o5O?=
 =?us-ascii?Q?f7HAkeegpesAihMYE52T3mK/+8L6RqFrLTaHcbu6OwRVJbNBqbj94QMqVsyM?=
 =?us-ascii?Q?CAdZajerpj3rwjDTPGPPu7DcLia/9K494ccOcrWSeAgyDRI79xGNPc44VfMR?=
 =?us-ascii?Q?FsKOHaw9eHOE8fLtjYfk3x6O1M4VkB0OgzcolC4TdheRaPb+btvHny4o6v/3?=
 =?us-ascii?Q?Vgbw92K7rVaCkeoWxVEjC5jg5VkzT5geKpeBrDEybCTguzWDr6GoEwALHetQ?=
 =?us-ascii?Q?+I9tVZ4HjQ0S2ABzvdkE2wEbM4cx2roZnvAGk3eZ2hGTY4NSgn1jacgNOISx?=
 =?us-ascii?Q?7uHdP3bLmzHjidvOR4YEI5YZpwhZH1cD7WB6C4o6clsg5vM0xXqYsWNju5CK?=
 =?us-ascii?Q?QKmhR6GqQUx9vsqrVe3M7yQHYAxaiciyj4B1kgyiwIkSMttCSG/yUS6MliV+?=
 =?us-ascii?Q?xp6fEZ6YSmmwW8Bum2g7/xffsuOuKgxaqSZqwTuvhBegFjNgTuesZc7LbMS6?=
 =?us-ascii?Q?pPZrX9+6p6rYLEx1uUKqQbH4clxkdUygg3EFFk+MkQ/HvN0GlB5StcQMkHUx?=
 =?us-ascii?Q?FnoYNRLJ1Lw3RcgaQXremDqQbh4wiWZMq7vcaqY11c4yWzGC9/7lsSbdAIqP?=
 =?us-ascii?Q?PKcuXXRUaBlkglHq1/xyso6KOKJQ6906ZGDsFAoIx0J68fsGu4lp7KI6t3PW?=
 =?us-ascii?Q?w5oxeu01ePxZggGT60GLoJyYenWrIfDkx4XOj74WVqGQ+p9iASzJe9yv0wCs?=
 =?us-ascii?Q?j3UGE3oZOk1avuJxUhnnpv5zg7GNB8iZOR6Zx5Ed5bWGB5SKCCpVTnQMxtRM?=
 =?us-ascii?Q?mM6k6ibhyPpH7g/IWi/yB/ryf2cVd/9CT/MiC3rAf1V5NKka/aN1zPIbN3iL?=
 =?us-ascii?Q?xlj3lz8Xc0Fw9u+RJYzaSnW+i9JTu98DpgZeuJFpJld/7Ho82hDE/2m7jL3d?=
 =?us-ascii?Q?dFmVMbjVM67VEn9tHQPH2w3Pjy3YCgB9EO3CTnryQ00o2w5JCtkpPQygMuRb?=
 =?us-ascii?Q?64MfnbO2i3P4bQUxyPzd1kDR9AdVtk99POMBV4vCcKcQ8xmd0R0Zh6gF/+Df?=
 =?us-ascii?Q?iMZa0ncfqP4ZZS3GGfH6bp24m1Xf+47lAShtIirjnW+0VrC9lQhDsXf/bw86?=
 =?us-ascii?Q?8diT8OfcX3fmA4LykxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+5KyMyJ+YPUrLlYsh8ZPoss4mc8tBzUBKAjk2f12+0HBliCiAa8vbxijVid?=
 =?us-ascii?Q?bEkWy9uAIwGR8fscjNHA+QJuT9ijV4VPlylQWNeMqVMm0w73PQColO09d4Oz?=
 =?us-ascii?Q?YdOcvPpS+pmab2AIrbwecL+lzsAorhT0bIkH6l8ccMWkLiybdBPyT1lY0exo?=
 =?us-ascii?Q?00Dd2ChH0ygQ8LR1kCjFwJYf7YOYjtX9mtpNhQl+10LvgPJqmqyH2wYXLFFU?=
 =?us-ascii?Q?65sbnQBEZSmJIqjJHQ8z9o6mwKs3q29dF+KrfNNyrPq371cDAJu3OUlhFLV3?=
 =?us-ascii?Q?0uL6Q+Zu7+ttfv/QK6PuSHszEeujWjOcrd+3GEulmpdVN5+Ng5cRMJKEjKO9?=
 =?us-ascii?Q?oBeQFD6/zMsODelmXVgVQAJEsptuisBiknFxQHLh4nzLFT+T5sJd3hCOMKfl?=
 =?us-ascii?Q?hiDn7lRnwon9JiF0Up+NjNEwEfdCrtv7/uYly8jVwrQ9dP5VHEnXwuMVw6wh?=
 =?us-ascii?Q?pvVvQrke12WkqMk+cqyUafM94Mu1P+GsQkCyOdb/X8ZFMhjX+vQ1Gbt1qWt7?=
 =?us-ascii?Q?//vkYf4SxG6RgC2lx6gaOMKJPhKAuaGmtvl90LGRZ213aQRVOg+mtMM3AGEd?=
 =?us-ascii?Q?npErRRaIqktTNxSqf9aMH+xYoE0iwGwZdc4hg6MbEWuHZkgTYf0KB8Rp6708?=
 =?us-ascii?Q?Buz5wfBjt1ZYaI5IzSFdHXJB7ESILtnXLcenoVy3PjxtVH6rWMaYcrInA8ou?=
 =?us-ascii?Q?OH9UbbAbxM95z4m6Ql4IoHJsBIeCY1rTeEW84IBjz3WLbbsuQRvMF++e8v8a?=
 =?us-ascii?Q?eg1HFhE/LudJL7QU3fGrSnFLSDpdVA9hqgjVflEZEdxja3kJDl7hmXpURiGV?=
 =?us-ascii?Q?ADiVavHNvPrOmUYBLP/YwQa7KdnK5+38m/hJoFk0tau4Ec+3Qd2AwzZszBwQ?=
 =?us-ascii?Q?3iYHA1ccbD12aRL1E3y9xGzMYlnZltMwiCVjo8yiagsM3mdZx0/Wz9cuhasq?=
 =?us-ascii?Q?9knMfNUHrLr5vzhGiwkfazTDuLEQyLkAEBiArPIb+vrrzOA5OWCe9jYKtplL?=
 =?us-ascii?Q?XW85Q108hlEpEjPPJ9tMDG86rbTCmHzm4LI408iy7Jv/3SQQ1uzw5W/wY+R9?=
 =?us-ascii?Q?7Ui612hJ9+Gb3eWh5LMXXwrhYfU8lyF8UCmYlRH6kutuwvz0O0mvnClRGlLc?=
 =?us-ascii?Q?7wtk+VD2WnT2SfK45QlGp2Io2qwO3WQtNGFF7sy5C7i7P1NCoXUV2bkU0hTu?=
 =?us-ascii?Q?7WetpT0s3sflFdn3NuN4E4RWLY18OZW7hCZfDi7Zr7iVTdadd1B3WgPFDUN2?=
 =?us-ascii?Q?kOn/gm9q4jYywXxOUpz8+UYH3glXlF0mkR+0TsZ/A1P0x9hLxfL91ZQqWG4P?=
 =?us-ascii?Q?s27FjrAPeDPq+Iv1qHe9a3HA3yaYnGm9FLnoRp53cbPRjSXbLjaoPfJVuA02?=
 =?us-ascii?Q?zA4G8l1gWqXRja7lLUscgzL8rQMiO2hZbAETaGBvOGQhrzAj7qt7Q2TzQoHk?=
 =?us-ascii?Q?q1Wytex501H8oF57h2gbUG3BTjqQvtM9PEYOtyWrHJzT5m3RYQa4Tpfy/kU4?=
 =?us-ascii?Q?eAu3tjAlFquSp7MfnfC68QkLjVgvzlFC7ewlH7sIdnxaqDjmbtez+lMfkXOV?=
 =?us-ascii?Q?mGeK4JT+wYu9wruFsHialDOSfCBAr1wmjW6naP0ILi604k7Kg2esPa37uG73?=
 =?us-ascii?Q?n/PhOtTWRy7tevoMh7e24NL50hLJCW4BNQUvlflZNsP3qjcDEQVu7uvDeluZ?=
 =?us-ascii?Q?ZYICqjoDLUSu41e9AFqZqaRKAQU9tNd/TB1esBTOqEU8x5LBlqFu/0uZbrD8?=
 =?us-ascii?Q?UYLrD2aGVwPNBcz+AXpb7OtRSvdRoY8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F5n6Q7YG7YxKGexVfUvsXhDPYVRsCI3OUyjMo2G6U0a3AbJIPbB1iXyPY84Wc3yQUlmNYLE2Bc8OSOq8c6B9cAwDYgZdXCpN+eY9Boi06vUN1GjevhL4uxAtT+zMyxvF9348i3RxrDFn9bRzB92on/x51M2cdBLZ5GRci3FNnTNtZleqfldVPEhOULwY6ZDumUSdDXXWwU5hyeqAco/kZPM8Bb5vBzutPWEBShFo9tt6dWxL3odM26QdE7ZqyoMrpaEt8QenMMLj9x987ECgunUm+EPGqQ5hfp8HXs5f2HxO0zda0v0zmv6AvPEgPShsmKPEQrcUxnB0uGydpZl/htP6qDqyoDQfl7WvUkTu2L/BFynan/JbvFl9rxBA8EtHWrglz2qj9Ktlz8ps13qIywadb8UlEfkb5yPtfU0p/bs8EtRYW5YrwSmJ9gH4b8aMfzWptgUFvdAJWVB7QTMEpZ3b9KzzaVesiNRC3PTrXwhGwk87yWikLfwdroTA4b7aaVcTKlvxGSy18wrWDaxDg2YIP8DnWToAqRCPNUBI2f1DcqExWFmgfjsLAJbQaITER0BU7Mzz/qJ5iMu1ZBEhGtwvUnBbJ+byEISC1URFKAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02993707-a3e2-463a-1816-08de5abbbb9f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 20:12:28.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmrAzeD1KnihslZWro2BrVW8hGKk339dDP2tducYduARb6Qvr274W+dUpwYoBrCspXKihGphe7DLH8o/XfB79tbtqLfmlNuJ0+xmbEMDsvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230154
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=6973d630 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=CG25fWBXb81_lYSilX4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1NSBTYWx0ZWRfX4LPJ5PANDEi8
 H/C/JA4B0UzrfXO/7AW+m24yRtqfKDnj0davuUp/9JUNdphtOlBWHA8ZM5WThtOfKdZ2E9r7OSQ
 idOIhDfq5Cuvb1dhhF5Obs7/n6mkzE75x4tnc50YMp4JBIURhJJd/FBNXbr4muU9D+QkHDzkQ3Q
 wt6Sm0gGedL0nWgD0NMu5BaH6hyvkblodupVsC6IrbX2cF/RDjYwLFFQ2pscMc+d/AbPyx4qpuQ
 QQCV0XJDdE998YcdOlxKUUBfMLz6kYDMN8gg8j8yaxoAzX8VZ1kbR8EFO9cu9/AABJvrA/NGzdz
 nQVoIbRYLkK6ccxj2mvRSIdupwN8iiyfhEQw/1Gqde/NlOm7izH3jBNkl8NKJEgiTgeWhTqgN3S
 x/tPQrxyGmYAiczt5jTKpi1eBZ9d1sv9inZkBMXsBGJT9rfp6T+NiW+Zh7lkh/R20NnEVRm4VLy
 QivWHE9p6sjOUhq2ujQ==
X-Proofpoint-ORIG-GUID: OS2PSasxI05vaL43tgTBZLvkkQ3XOSFu
X-Proofpoint-GUID: OS2PSasxI05vaL43tgTBZLvkkQ3XOSFu

The code is littered with inscrutable and duplicative lockdep incantations,
replace these with defines which explain what is going on and add
commentary to explain what we're doing.

If lockdep is disabled these become no-ops. We must use defines so _RET_IP_
remains meaningful.

These are self-documenting and aid readability of the code.

Additionally, instead of using the confusing rwsem_*() form for something
that is emphatically not an rwsem, we instead explicitly use
lock_[acquired, release]_shared/exclusive() lockdep invocations since we
are doing something rather custom here and these make more sense to use.

No functional change intended.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 37 ++++++++++++++++++++++++++++++++++---
 mm/mmap_lock.c            | 10 +++++-----
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 294fb282052d..1887ca55ead7 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -78,6 +78,37 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
+/*
+ * VMA locks do not behave like most ordinary locks found in the kernel, so we
+ * cannot quite have full lockdep tracking in the way we would ideally prefer.
+ *
+ * Read locks act as shared locks which exclude an exclusive lock being
+ * taken. We therefore mark these accordingly on read lock acquire/release.
+ *
+ * Write locks are acquired exclusively per-VMA, but released in a shared
+ * fashion, that is upon vma_end_write_all(), we update the mmap's seqcount such
+ * that write lock is released.
+ *
+ * We therefore cannot track write locks per-VMA, nor do we try. Mitigating this
+ * is the fact that, of course, we do lockdep-track the mmap lock rwsem which
+ * must be held when taking a VMA write lock.
+ *
+ * We do, however, want to indicate that during either acquisition of a VMA
+ * write lock or detachment of a VMA that we require the lock held be exclusive,
+ * so we utilise lockdep to do so.
+ */
+#define __vma_lockdep_acquire_read(vma) \
+	lock_acquire_shared(&vma->vmlock_dep_map, 0, 1, NULL, _RET_IP_)
+#define __vma_lockdep_release_read(vma) \
+	lock_release(&vma->vmlock_dep_map, _RET_IP_)
+#define __vma_lockdep_acquire_exclusive(vma) \
+	lock_acquire_exclusive(&vma->vmlock_dep_map, 0, 0, NULL, _RET_IP_)
+#define __vma_lockdep_release_exclusive(vma) \
+	lock_release(&vma->vmlock_dep_map, _RET_IP_)
+/* Only meaningful if CONFIG_LOCK_STAT is defined. */
+#define __vma_lockdep_stat_mark_acquired(vma) \
+	lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -176,9 +207,9 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
 	struct mm_struct *mm = vma->vm_mm;
 	int newcnt;
 
-	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
-
+	__vma_lockdep_release_read(vma);
 	newcnt = __vma_refcount_put_return(vma);
+
 	/*
 	 * __vma_enter_locked() may be sleeping waiting for readers to drop
 	 * their reference count, so wake it up if we were the last reader
@@ -207,7 +238,7 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
 							      VM_REFCNT_LIMIT)))
 		return false;
 
-	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
+	__vma_lockdep_acquire_read(vma);
 	return true;
 }
 
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 6be1bbcde09e..85b2ae1d9720 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -72,7 +72,7 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 	if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->vm_refcnt))
 		return 0;
 
-	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
+	__vma_lockdep_acquire_exclusive(vma);
 	err = rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
 		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
 		   state);
@@ -85,10 +85,10 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 			WARN_ON_ONCE(!detaching);
 			err = 0;
 		}
-		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+		__vma_lockdep_release_exclusive(vma);
 		return err;
 	}
-	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
+	__vma_lockdep_stat_mark_acquired(vma);
 
 	return 1;
 }
@@ -97,7 +97,7 @@ static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
 {
 	*detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
 					  &vma->vm_refcnt);
-	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+	__vma_lockdep_release_exclusive(vma);
 }
 
 int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
@@ -204,7 +204,7 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 		goto err;
 	}
 
-	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
+	__vma_lockdep_acquire_read(vma);
 
 	if (unlikely(vma->vm_mm != mm))
 		goto err_unstable;
-- 
2.52.0

