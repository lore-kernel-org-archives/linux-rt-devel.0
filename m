Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1F2E11C5
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086264; cv=fail; b=gQHhDLy625i/0yrZAwXCxVcEGOkQI4MsR3rw9Axe3VlDF4EY2a72HHmA54fx1/RTDaJ8VQ1yNGLPN42zkZ6BaVIwZxjzBiCMfbvI7WoKfci49QHdLt9pzVSei20yBNA1u7t6pR20gzmTBQ6HmHdn4spuLQBavfjUwfXvfglzj/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086264; c=relaxed/simple;
	bh=XNLp2s/kOrJ33R0CG4Di8UjK49SCGIUWZVZbTzGwLHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdToYkCCCrjvC/DssAMmSPa/62+UIIEMbJBREjx/iyeGlJdUVYZZkTNNnnyFZr8n6EohS6vgl8jdAVB4Ztc2DgINozzAmwKHEzFy3QHg5gNAbCuQerl34bEi5CxatY24f9HPDs58qfy9cxzB4gjHOL/uXkqnU6SYnB0p5HU4Fb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1Hotn+k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pYeZ5ZVK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1Hotn+k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pYeZ5ZVK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LNL0Ne3266582;
	Thu, 22 Jan 2026 12:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yy0BJd+j2CMRhYrJIQz2+9BlqjIfVO6MZl1p7+ODLG0=; b=
	j1Hotn+ktuhoju4pYshp9wcx71OD94kQROmqCaMqdqW1p09EWeyNhIEGeSPP/uaE
	NduJuWT2mW8gYAVzixfXZS9TUomAUg/jFDH9NK0btE4huXz4BsXdLxiDbSSXL6Oz
	Myk/11lavRycEltxSrXvtxzWZkBk5QZdwCAuv0/FVu9yfaGIX5tDWJ3NSmu6U4pl
	iT2Ie/R4fFu4dJoreyd8x1eghAnhDw0olXBXmfXEKCK+HOAajBHKIdGLqhr7QruG
	h9SR13oPxAbp0wKWSMDAAO9FYWqtesK7dopg+uB+XC7IsCU5c9pAr4JBbSXBUe4B
	wsXcK+qZ8B558U4eiofnYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8fntp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 12:50:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MAha5J024905;
	Thu, 22 Jan 2026 12:50:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujcyv4u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 12:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKig+1BgP5bZ4/BP9gl3wvSH0Z7kxcCZkPoGVL8vNtDCgx/sieORCMo47aFLJ6kN/pxhrqMljzvBRqEOtRXmBgR7FmGwVfmfvkrqv8YNl5NMjGHLZao0YlPtrQAD9XY5RtlqhRGiKfJ6253C9BLliZWzs92sngqvG2rLBFUpZmquMllT/l4BnLELKfxE1iH8cqdcg7wODLMbXzQou0Yjj9cAmqq8ax9cT/Gncg8+LXgJWReciNqhI4hR6TJ3+KXPRNGVjwK59ihjvp2OzI0KPVZNbcKQMyUXa+FUWja1Une5KgMF5U166SzXa5a0a8kk0B++wmSP+8q2H+vMW7oDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy0BJd+j2CMRhYrJIQz2+9BlqjIfVO6MZl1p7+ODLG0=;
 b=n+fP8Fn5TqJpaj9jr9i2lk2MXzEuvG3pP0YsqZE7lhSbTj2K1XmpN83zeSqTSdzuOqhfyI/mPPRFBtksS7JiZe5BhUXpKTd9Ko1woAySH7y4DcTZRbJUtC9ZR/ArI/aoBLcDOBZ1t51263dmWu/lYYPhUAB78AgivpQ2sWwrHOOWz/L1VkSE8aU/E72OIdTB/FC5bl8BNLv+y78tXbTQsFitDBPmIZSQexfHgVqah3VcnBrq+uyAiE1zxdRinGi5cLH2jKkGWg+7xeTiHg8/pfKXEC20Bgymra82r38MalN0+Km7mSOVp+bX0JrrpCVxiwQ3cYDQao+17w4BRjCmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy0BJd+j2CMRhYrJIQz2+9BlqjIfVO6MZl1p7+ODLG0=;
 b=pYeZ5ZVKWCuSvM3YYomYxFENdF9mwHRC15jC2lAZ5/owJfiagC4icyZM+IdQnVX0PuEAgrUK+iFnJABALMp4ZVs1v+JtFX8//R9kniRhsu67sVnjuMCSeb7qFW+WzdryUR0MrErL7UdepdbS6U2A8hMvc+9sgLM59/4OV6yi3CQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PR10MB997622.namprd10.prod.outlook.com (2603:10b6:8:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 12:50:36 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 12:50:36 +0000
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
Subject: [PATCH v3 3/8] mm/vma: rename is_vma_write_only(), separate out shared refcount put
Date: Thu, 22 Jan 2026 12:50:23 +0000
Message-ID: <c51d6396d78532d85a542da07ba783bc838b852f.1769085814.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769085814.git.lorenzo.stoakes@oracle.com>
References: <cover.1769085814.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PR10MB997622:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd49dfc-606c-4f35-42da-08de59b4d6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bajR0oNgPk1tkyCg7Tu+u/rw6Ae8U30S2oRZNpC8+XtNHc92f+9EYpgxEM16?=
 =?us-ascii?Q?IiAwhKAcgxkDaZJYgik4iTrRI9Urv8RSf2RmxusGMQZ1xlVmcS0zizovZEYt?=
 =?us-ascii?Q?x/aaIJi36odypJUd9A/5i/tZ298hk2A1newtpRhgBTyx8BrFEeNQAsbPxt7J?=
 =?us-ascii?Q?GKNEQBvTfGCx3QSy1L7FEqXu8ieRMA0RP/MQ/HN7NwEz0XvSmFEUSHx9vv4m?=
 =?us-ascii?Q?k/iU89ukCGYfzzoL72FiW5rjn/sSVw2/x0yMcU/K4cXOauMFFAqOJVYtXSwC?=
 =?us-ascii?Q?E8CGKmW5LjK7JyqmvYNDCdcydUESmWNrY2YUgY35vpP/64t/pKzQRR9w1R+a?=
 =?us-ascii?Q?Px5Rj1ww0gJLGNCakDS6+UAR5iAKNJl4H8xl0XZQuXfsBdpHmIFnCue183LZ?=
 =?us-ascii?Q?H0Y5J456vGmd85zXripuyhWAc3DTlAM6XpsXokFg6fNEyO47ghTLtI8uvrEh?=
 =?us-ascii?Q?rbimG+gT3ZvUfP6+JcIwebGgQLK7YmYnTlc84K/qTFumo3J9ekUhZ615t0n0?=
 =?us-ascii?Q?vT7A4tqJ1+gnULJhnpvGofBPlS0fjREgBlz8pJ/2hlBWeqFsYHcZtNJcCXWy?=
 =?us-ascii?Q?hbgHQDFfZpP6NAqw6wchCUmBZiH6wzg6vwuAAc7ekkW+g1ml57sRRYmKlLwT?=
 =?us-ascii?Q?xYSic2fWssmHdFec6yedkt5b0G+yIAg1kS1FijM4Hv+lyOMHxjpCf6hyvfcn?=
 =?us-ascii?Q?L9cBv9lvZJzpsIGvkUahPxFxJd7NzcXCt1jdiLc9V9Hvrna8Oj+96WO8xZRB?=
 =?us-ascii?Q?kol7JTurn/v9Ug/VRM8FL66y5XeufE+JGAmuFC91X4VrkzEIHSf85UhFDXVM?=
 =?us-ascii?Q?6ZqJjgI+kQekFrCZgDuxAPfqlWslvTjnSQpr3OWUBfLm2wZGiMSD1C9a7t5u?=
 =?us-ascii?Q?iD02nYdBrAzvhyTfddw5dYCSZOWrjaLfxB4eQlZXE5x9llDxUCRhsrM3+Rlt?=
 =?us-ascii?Q?v5NpAfZv9uj6kaFcUBdwPRYhYitbETp9hYG6cILUDMmdekPZd9q31OOy+XUj?=
 =?us-ascii?Q?15UJeFDEXNFXTq9Njqw6NmJEblFWn1YjznZaXUD+YTz7Ehm0XzmqLGh98JWc?=
 =?us-ascii?Q?WMWA7GWofSxbndJaeBahYwT56AWmbT+77nISqq63Pn5fgOQHJc347mtd+Al0?=
 =?us-ascii?Q?iVSdkTaSuEDyouzmiGujP2NRuVsk3j6IrGCV5Yy1L4i6TDS7sR5Dwi/z07ka?=
 =?us-ascii?Q?38+vCZ5oAR8eD9s6kjh4jAhwKPgAGUDPQl4L2qb5Csic5LUmwg8trmMm7JBz?=
 =?us-ascii?Q?Csd7KEy1HwiTfehNQ9K9dq3WU9Z0qXxAh/LyMC92nTWkeLirg8U6tSoT3034?=
 =?us-ascii?Q?wWsrQu18vZxrX49gmSoGMq52MKDVVQlb3KfXCejy205yA0k7Be8uhrX/41BA?=
 =?us-ascii?Q?deC/f6F2E8z6T+qhYHLgsjWuqk0/JkSM0dQQjqVQjtqXF9S1epqhCj8YPGyl?=
 =?us-ascii?Q?oQ5e231FdTUYkFlEwNQbkYt9YI1tBVOboNxw1utRx+peCHOJgoLcmIaPOml3?=
 =?us-ascii?Q?ygpWWRVDNspe+aXic4W+V2qR8UBUjr7avfD94aYqhljzWCIqFZvcJtt6J6Wo?=
 =?us-ascii?Q?atJbIQ21mBqEGEXC5as=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+EjOI3IdyeN/fxz+2Eg3i/fYu2KmoO4hR9tnS5D81VVJdwEZjio+c4JsXJBN?=
 =?us-ascii?Q?okigW2f1PvsyO5myHdmpzPjtXiDwIWHTyRwg5YpedNNt5PuN7yQCNp15RHIh?=
 =?us-ascii?Q?z5ZsjwMaTj4xprdu8XGWllKK8qo/X+p0U0ob9wzuAFNuZfPEY9pz+jPFPQPy?=
 =?us-ascii?Q?NSe+rwFonYW2ZvE1vtwTzfqb3/9OYGtVTS9oggp9u9ZNEKCdVVKOavCeOm6B?=
 =?us-ascii?Q?zSQ28meIYUZxYkAhE4IbVuBp3EHzKgTqLk2PFPjr3sXeiOkOQ0DAY87YbLo+?=
 =?us-ascii?Q?wKz1rVyH5WHPBxj+jCzV8f3RuODGOncSxJpxGAnQ+Mt5s61Dh0yx9uvSGC7U?=
 =?us-ascii?Q?B9ay9WDm3vzhfXefiLvs1uFkKTkKgfrE51i+Dr6eX0aI1KzXLYoQsQ8EpWB1?=
 =?us-ascii?Q?1klEQUvyeeYuK8fX7fMzooSQGEMCPigPQUaH7oYZdcFkYGXjkqvdl5M6MPnm?=
 =?us-ascii?Q?e6Jlr61/FiTDFxVvdU0K0PXmZVP7OujivjfGDZPu+sj5Ty3AcqExRkoapoCe?=
 =?us-ascii?Q?NShZTNez3Nh2R7MD4rJ4lEbGvARp2JpG54nNowQnky4Lkq4XS3vpXAS71Mhg?=
 =?us-ascii?Q?DnRwLpKlaX5Gv0h8YgCAH/lKw816DhpwJPOvwUufyI2yIHF9+Zzxx4Xgi9BD?=
 =?us-ascii?Q?bGdfMEUey3Eip9gFOfTbObaGlSd8/NX6nPzQOtwVUk1uMgNl0kVjGvE1fyRt?=
 =?us-ascii?Q?fhwhjIuJEvo0M68MArIEv8p7JcwpKKIGakmQUKwPXC+ldFixvE15p2hK4bNk?=
 =?us-ascii?Q?ehdTzy4bVuyTcidVPYtQSxGuGMQr87MtMg2gdyo7c71+dMhpRuE0uvav40HB?=
 =?us-ascii?Q?E6Ttxtufc9I1tXX3NJOIbZgFhvLVKUux8+hi5NRHVduX+Ub5FsybxWLkxNyX?=
 =?us-ascii?Q?Yqg8ndfdCVjBIDdfbFxgkJlHq0mDSBEm+ocRN3P8pRiKdjwaIWcGSt1IqMd1?=
 =?us-ascii?Q?z7E9VL1usitqOFFIJNtBy0p0aKRDhLIasozmw3ms8jCOfimMKVlMruJwnqTb?=
 =?us-ascii?Q?ilQkxRMj79ap6R/uJ/oiIOsi6a1NVCOddCfdtGDUmug9wM4ZAwSTjZtoKvTZ?=
 =?us-ascii?Q?HQXccaLckzxoo/1Qv7tVG9DNthMhVnpJg4V+TuABBrymeuq5q2tAeLWtev9l?=
 =?us-ascii?Q?+PM5D1BryRhPtutmDHP+8bo4Xg4AQ/t8Y5pQFq/uwPoebOVyuJiVHcQ0p+Cd?=
 =?us-ascii?Q?XGLu2q4OkjLHpaj6s+LPWkuR2+Vi+fW4We3pPVz9HdcftHwkSOHgV1u5Kda3?=
 =?us-ascii?Q?QX0Q/PUEoWA/DPGRk+icx0wtqPWPACjefCOAhGstyw3v8daDonO9Vfp9n+Of?=
 =?us-ascii?Q?onELEM4digmPtJRpQm5xnTPL2EV14JHp4SotYLoJdGCsfVseeT86oCkmxFf9?=
 =?us-ascii?Q?hTdqreiK1J0PbnHBltiwMXa+cl2ZYBmiTpQZbbfmqixhFac/QRLqysuKp9Qw?=
 =?us-ascii?Q?bOHpwHddKYtIhEw4L9MommH59fhEPUktR1uf043PEIhcFfIuCWf9QgLvPjVH?=
 =?us-ascii?Q?iBKWiWKSQW4scYa7jbz5GwJqjLfA4yeRH37Ej4jsbqc8305O5bc68fc3gpY2?=
 =?us-ascii?Q?x9sQO5lINO5qX2Z2fMvYC3Xu0nCS1849TsY+w58zBtvC+XyQTd0O4iKTPPhe?=
 =?us-ascii?Q?gMzcDUN7c+GOXPqrN9Ii3UqtgztccHvhOYXdSL6eqPQnJR1z5RegrKInsKp0?=
 =?us-ascii?Q?U0JwQQm7t5RAVya4Yg1Y7n75Qg6VObsprfN2UGfR0e034g0wV6fZ8kKuc5js?=
 =?us-ascii?Q?q9AztDLQajeQj5C6rBm4KvodupH8mas=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vA+4zx9VJENkapHjb5vIbxlaB7ngVkGkdlEcccunSIcDJ103+PkEw6KV25x7I+SzELaLKqwIyhfRXyNsJi7nabs1HoKseUSOI+8VxNSb6/ayOGa6B7rayC7zS3OL3fwJumJxvpE9vawLnsczCGsqiUp2g/KfP2i05AKd6Mj2mdBFDf0nU41k+5HhkEZoKNkztkXXFzQW5dfE3EVi27MLClbD/saJV0G1/6ATJKL/JzZQV3BoLZXLUDf8Ky8iAcbSNlxx28/sB0ic3IGvgImeyd5H83ohz1hVyYPUrZFi/cUYNC37K/gcMQv5xB/Mdawq5nsKp3Dj64OY6s/NBRVl+7TLaQ1tWHeo4FS1lFcYHZqBLsKz0soDPhn96dPSTlNU3Al7u2b4QvuQ5tc5JiRy1NdpUrenjJf2SEBj4i42UBjHmGLiM90YLernsR9Q/L0L6veqtgy5xc3yP0+uG+g70jJJ/RRZzjlYNq2T0npI9bfd/ImirDv0GieO4mTg/Zb8mJBiXavWbcqcJ+hZFZUUGGYGIHyG2HoVwOshjxrc6VEC3jAzDffifF5vwvhP4W1/xAhj8Y8tvR6fF/Yqh4knRjdEZeci3Dr3Qn9QQg2ae5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd49dfc-606c-4f35-42da-08de59b4d6b5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:36.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvLqbsnGceEuFp4ugsUpwlUBJtWk+yKOeEcwlrm4WVqZ/PHwNaBnlC6Vhlxac2oXTxH0SmtW2SNNaUdZS2xEtzKrxe9nH0MeNx7fM27OLI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220095
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69721d20 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=fUIvD_cNObhrxFjjdL4A:9 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfX4CF2LNdVFuPD
 /wWdV08wr3GfBivtNGsrTlsZStbdetXr+azSna3p2bKh+TvThfO/CoxddAdLi79WUUvyzRuzkBD
 l3S/B9m8fumvBgl9EoywbGPTiwKiRSuJ/IvVlDvxAZIVGYli/fAtGD7RQrXO9wW5fU0aAmOaHwz
 0jSOwnRWCRtNb4rZJV+C0gCiLNzLSxGRpPtjvdNqtVg8kUE9jX5G+FFncla+ZNeQe1ozdrY2RAG
 Yx3wa7sjPdJtannKH5dM9PaxVH/gA5cnOIp0JFc7XQbHFgz4JS3vgPR2PihRTq5d5W3OZdG6sb1
 MhSRadrD9oUZYGiy+CbuJt+ZgLxiQw4HO8Vdh5qgnoaExrn/p2ayfhNMdOTmXnKBrXm4k/Q9DO1
 K87M7B44HBgE9VOHx/YkeRsAiuJ4T33PpqhMvDuLzfBnv1u98tUdLKfNNAVBaEuhfSqXeieO3Ex
 ShioMCr9vJAvF5/xJhxAbmwXlT5J1h5KsH7uBtLM=
X-Proofpoint-ORIG-GUID: gQgOuvc1vkq2314ohqrp5FtoQRTsBwVZ
X-Proofpoint-GUID: gQgOuvc1vkq2314ohqrp5FtoQRTsBwVZ

The is_vma_writer_only() function is misnamed - this isn't determining if
there is only a write lock, as it checks for the presence of the
VM_REFCNT_EXCLUDE_READERS_FLAG.

Really, it is checking to see whether readers are excluded, with a
possibility of a false positive in the case of a detachment (there we
expect the vma->vm_refcnt to eventually be set to
VM_REFCNT_EXCLUDE_READERS_FLAG, whereas for an attached VMA we expect it to
eventually be set to VM_REFCNT_EXCLUDE_READERS_FLAG + 1).

Rename the function accordingly.

Relatedly, we use a finnicky __refcount_dec_and_test() primitive directly
in vma_refcount_put(), using the old value to determine what the reference
count ought to be after the operation is complete (ignoring racing
reference count adjustments).

Wrap this into a __vma_refcount_put() function, which we can then utilise
in vma_mark_detached() and thus keep the refcount primitive usage
abstracted.

Also adjust comments, removing duplicative comments covered elsewhere and
adding more to aid understanding.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 62 +++++++++++++++++++++++++++++++--------
 mm/mmap_lock.c            | 18 +++++-------
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index a764439d0276..0b3614aadbb4 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -122,15 +122,27 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-static inline bool is_vma_writer_only(int refcnt)
+/**
+ * are_readers_excluded() - Determine whether @refcnt describes a VMA which has
+ * excluded all VMA read locks.
+ * @refcnt: The VMA reference count obtained from vm_area_struct->vm_refcnt.
+ *
+ * We may be raced by other readers temporarily incrementing the reference
+ * count, though the race window is very small, this might cause spurious
+ * wakeups.
+ *
+ * In the case of a detached VMA, we may incorrectly indicate that readers are
+ * excluded when one remains, because in that scenario we target a refcount of
+ * VM_REFCNT_EXCLUDE_READERS_FLAG, rather than the attached target of
+ * VM_REFCNT_EXCLUDE_READERS_FLAG + 1.
+ *
+ * However, the race window for that is very small so it is unlikely.
+ *
+ * Returns: true if readers are excluded, false otherwise.
+ */
+static inline bool are_readers_excluded(int refcnt)
 {
 	/*
-	 * With a writer and no readers, refcnt is VM_REFCNT_EXCLUDE_READERS_FLAG
-	 * if the vma is detached and (VM_REFCNT_EXCLUDE_READERS_FLAG + 1) if it is
-	 * attached. Waiting on a detached vma happens only in
-	 * vma_mark_detached() and is a rare case, therefore most of the time
-	 * there will be no unnecessary wakeup.
-	 *
 	 * See the comment describing the vm_area_struct->vm_refcnt field for
 	 * details of possible refcnt values.
 	 */
@@ -138,18 +150,42 @@ static inline bool is_vma_writer_only(int refcnt)
 		refcnt <= VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
 }
 
+static inline bool __vma_refcount_put(struct vm_area_struct *vma, int *refcnt)
+{
+	int oldcnt;
+	bool detached;
+
+	detached = __refcount_dec_and_test(&vma->vm_refcnt, &oldcnt);
+	if (refcnt)
+		*refcnt = oldcnt - 1;
+	return detached;
+}
+
+/**
+ * vma_refcount_put() - Drop reference count in VMA vm_refcnt field due to a
+ * read-lock being dropped.
+ * @vma: The VMA whose reference count we wish to decrement.
+ *
+ * If we were the last reader, wake up threads waiting to obtain an exclusive
+ * lock.
+ */
 static inline void vma_refcount_put(struct vm_area_struct *vma)
 {
-	/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
+	/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt. */
 	struct mm_struct *mm = vma->vm_mm;
-	int oldcnt;
+	int refcnt;
+	bool detached;
 
 	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
-	if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
 
-		if (is_vma_writer_only(oldcnt - 1))
-			rcuwait_wake_up(&mm->vma_writer_wait);
-	}
+	detached = __vma_refcount_put(vma, &refcnt);
+	/*
+	 * __vma_enter_locked() may be sleeping waiting for readers to drop
+	 * their reference count, so wake it up if we were the last reader
+	 * blocking it from being acquired.
+	 */
+	if (!detached && are_readers_excluded(refcnt))
+		rcuwait_wake_up(&mm->vma_writer_wait);
 }
 
 /*
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 75dc098aea14..ebacb57e5f16 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -130,25 +130,23 @@ EXPORT_SYMBOL_GPL(__vma_start_write);
 
 void vma_mark_detached(struct vm_area_struct *vma)
 {
+	bool detached;
+
 	vma_assert_write_locked(vma);
 	vma_assert_attached(vma);
 
 	/*
-	 * We are the only writer, so no need to use vma_refcount_put().
-	 * The condition below is unlikely because the vma has been already
-	 * write-locked and readers can increment vm_refcnt only temporarily
-	 * before they check vm_lock_seq, realize the vma is locked and drop
-	 * back the vm_refcnt. That is a narrow window for observing a raised
-	 * vm_refcnt.
-	 *
 	 * See the comment describing the vm_area_struct->vm_refcnt field for
 	 * details of possible refcnt values.
 	 */
-	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
+	detached = __vma_refcount_put(vma, NULL);
+	if (unlikely(!detached)) {
 		/* Wait until vma is detached with no readers. */
 		if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) {
-			bool detached;
-
+			/*
+			 * Once this is complete, no readers can increment the
+			 * reference count, and the VMA is marked detached.
+			 */
 			__vma_exit_locked(vma, &detached);
 			WARN_ON_ONCE(!detached);
 		}
-- 
2.52.0

