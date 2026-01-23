Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84184125A0
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181090; cv=fail; b=QF+936D1QJIGT9OEReLxB8JCU4t5NCjHaDFyPkaye29Clh/0zgYB+LcU4nDy3xAENe8TdvRn6dyNyMYbcKMjtwcEXxIrBsUdjV9PFeVxLUvARij3ERnAJKIO6h5WFzT4ECkMF/Uk6phixSVRQfFu2qfdQ5EBaVUkutGKnQEoRiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181090; c=relaxed/simple;
	bh=8vfl+jsXZhaZKui2LAUrBpxUYcRWSv9Ev5Ed3vCHxN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T72K/fEGWcd+PZhhVehGlAPpcRhlO8qs6wTaoFO68MBc4x4N94Id/xdpd6I34FOIk9qWnpiMcliKJALuc4p5xMwV1AasCzQtkD2UHC71LocWQQXk51XHHh31GJKo5kdGwNZZuRB4XU0jrl8Sy4+zpmRFS/3g3Tak+t4DkYl2p9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V5kkJ9fT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbapJKnh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V5kkJ9fT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbapJKnh"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N3EEXO2401286;
	Fri, 23 Jan 2026 15:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8vfl+jsXZhaZKui2LAUrBpxUYcRWSv9Ev5Ed3vCHxN8=; b=
	V5kkJ9fTJNzCHCBGIPPhzZ8DYzP9BNJaeLKw8QK39mqIM12WUDkxoDGRI/yo9Zi1
	qKsD/jSUTTr42Jsfxa2C95f0GznLIgDeLbfTmjdnbDEiIN29F2hOHf1C6q+gJYJn
	T3DJRE/e0OZuysDv0f8922yj3jizftaqVpNYfjs/uKiLBc6BKcYN9lJe5hA8/3Qw
	8tEwxxADuHwuCizuJawZT/c+9zOqh1iN4L2l25W0lv1hpIwd2SK5hPrjHPCKLOw7
	UDWhaOLvipffIsyjGZ7x4qSl2lJ2pd3qUAPV3InC0N8vKuwHGweX724FA8yYFjZZ
	2qfqQFs4rjdhc5dqnsaHoA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qjpfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 15:11:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NF3mwu032913;
	Fri, 23 Jan 2026 15:11:11 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvexxud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 15:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukXKBJ/xpximxuOnd5i9qCWleaBRLCmYHSs/9VGuru+CMaIqm6JoR71Kr7WPmEZ4CyoXA6qLF1Pgqh7ogYkUu/6bKno42pwaUxh0Hv2t2Y+r6dqJdkvL0l2UgHFj7lrEI5iH5EN/P8Nwf4nX1Mcf+1GkD5ZAhzAUJ2dHOw1INTuejfUc4EpGmGI6y8M+PLu0fFKEeKT+RW8JNnXZFFUZLXWPpfM9Blxg8nIb/LtHbAo48Bkeq2HHIvzg4o2+HrJ5JvqZHHNH2lELFXzkJqQ2wh+cG+ZPcyKhnRiJ3hoyzek9haK5xWCPRAHT9xxU1RikCI/7NVVon2pvAHE0CEMazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vfl+jsXZhaZKui2LAUrBpxUYcRWSv9Ev5Ed3vCHxN8=;
 b=IkvTitAf7FcJlz5hxrz60x8nKucfj2yazVwpEcM1onrTBLQbImj5llplzbilj/jVHpyZfthVQo5s3wRHXK0hebjU8vQZsAevaVCDvLgwMFJq6UPfQbOhJOtnSfN8Imct0p85sHKp2uhcsunwkTMyM2YpIxQd2IdQ91OirDj+ISPUELQ1h/u8L5qB8R3NSYIBCf13kPCY+pp2GHAUMlyfUZxYC9uxuhjshAqJ2We5YuvUwEJOeMGO53ePkEYTJ3kv4OX3+y+xPR0nxzlPig47fEpcsS9XnaM5ixswBOhbbRYDDoM0os0kmv6azqiBROuKD0c4CLad5QoMLdO5LwlO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vfl+jsXZhaZKui2LAUrBpxUYcRWSv9Ev5Ed3vCHxN8=;
 b=YbapJKnhSRBBwiPfZrqM/8lQMnp/tV1fXLCdnIcoNN95tOT97gcphlG80Cp5NYKbqoYYCApWoicFLlTYGo0MJuSJNlPcDsKUfxRrKtu1HxMmF0nQ+fqqUxPIuDTlSOiOluwsJ+xt3cw5O4MHDhsygCoUyqulVKbUCf7zShEW/xY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY8PR10MB7367.namprd10.prod.outlook.com (2603:10b6:930:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:11:03 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 15:11:03 +0000
Date: Fri, 23 Jan 2026 15:11:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND v3 05/10] mm/vma: de-duplicate
 __vma_enter_locked() error path
Message-ID: <54cfdeef-23be-4d7e-a4ab-2db53952fe65@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <2611b2b6957b7aef587e9ae62712a888159dce60.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEv+aag1s2Aa=moCueyfB38hmSJFJ4ieZwthRdsKZEhWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEv+aag1s2Aa=moCueyfB38hmSJFJ4ieZwthRdsKZEhWA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY8PR10MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: cf934cbf-01c1-414f-bf65-08de5a919fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXFHTXczTSttTkxCOUxjVTdxdGNzUmVUclBmcVdFblBaako0SktLYm5uaG8r?=
 =?utf-8?B?aDVnSVZmSnFHeStLbXF2TW9haFk0RU9PTWlHa2trS202SHZSV21BaXY1SmdK?=
 =?utf-8?B?WWlyempMc0FpNGpGdkMrbG81T1NjSXpxc2d4blhWOVdnS0ZuWHg3dWdSRUMr?=
 =?utf-8?B?VmxXSEovVEtaeGduZUFSVHhaZnN2SUY3bmJsMkVnYmhaTlo1VVQrU0pGQ0xV?=
 =?utf-8?B?bkJHUHRwL2lmYVJWT2NUSnZNa1k3dkNPT0ZrZDlseWdZbmw1dGpwWHVYYXNE?=
 =?utf-8?B?YzBnWXpMU3R1VGhML0g0dGI1ZUF6Y0pmWjRKZzJGTVlTRE4rTHgvdjVUb2lR?=
 =?utf-8?B?MDUzdDhtK05OYnRjYzVPM09BbC9RMXl6TzYyMU1kcE1nNTNNOWVzYy9Ibi9D?=
 =?utf-8?B?WWFPZWpWRUkvSHVsTWg3bmk1YlB0VmdVazRtVUthQlk2YVlkVlJFTUtDd1Ro?=
 =?utf-8?B?SmRWZE5UT3l3SEtBWmduWXNRUjlOYXVKeHM4Z1VQQW8xRWFicUhGUEJTSy8w?=
 =?utf-8?B?WjF0SXczL2tJdEMzY1YwazM4ZWFSNVRuNC9qMzB3NTVyVkFaK1lsSWZvZm5N?=
 =?utf-8?B?UW1BZVNaKzNDTlJKL3dwS3AxTXZyZDdIL1QzMHZpZDdwUUVPVVZid2t0ek9q?=
 =?utf-8?B?SkNua3NZNFFUNk1qelJ4dkM1Wk54NWR5ZUQ2TENMam1iUEpQWk1QVk5EeGd3?=
 =?utf-8?B?TXNKMVd1UGdNWFRkMG4vVkMzUW1RRGdiZWtaUTVsbXM3RXhWZ3FGLzFwSlZJ?=
 =?utf-8?B?Q0NaclR4dDIvTkVqRkt5NU5ZZkJjbEJORXU2WTZBV0J2cGF6NWNCWkJIY0dV?=
 =?utf-8?B?VExNVEsvckFoZUdDZ2JPU1FPUkFXSjdSY0lQTXlaZ1FMTzNpWjNuKzNqeEZr?=
 =?utf-8?B?YW9jTFE2V3BtVVMwZFUxUS92d21OL1cxNktCNy9URG9kaGxESEZyWVdHZHYv?=
 =?utf-8?B?QnBHSzFPa0xENGxGcW5pUlM0aSsvZ0NWditlaWoyMDV2YnRTREd4SWNpWU1W?=
 =?utf-8?B?VUtraC8vWUFRcExrSHRQRTdQOS85M0NJR2sxMnZvZFVJSGNRY0lRWXozKzBH?=
 =?utf-8?B?VHZhZm1BKzNMb1Mvbit6aEJLdVhQS0RRWElCMkp2TDM2Y1BxdFcxRmNFWWRi?=
 =?utf-8?B?NVUrc3l3cjdJKzAxekRWQTRGS01pNUNVOHg3SXRvcHV5T3gxYzk4NFRySDBY?=
 =?utf-8?B?aGZIeExjNTVoSWhuUEY3QmE0eGYzMTUzandKTHlldGhhVm11ZWxNTW8wKzd3?=
 =?utf-8?B?UG5qR3UxZkxtdGtEQmZCME1HZlJGNXNYSUpPaERLa0U3UkNQR2lJTkFFbzJ3?=
 =?utf-8?B?Z2hSNVNSV1hZcXhxOXlPRzYwUVRoaytjOHFzUmQ2ZVVpODJGN2VlYmpMdjh1?=
 =?utf-8?B?RFFsbDdiYU9HdFg5S2xWcGorUTJSTkVCajBWR1J5bGVUV0M2a29ibnFQaUVY?=
 =?utf-8?B?RlVRWlNHYzJybHVZU1VGOVIrcGtVZnVMQkNldU5mRFRTc1p3OU53azErYkZx?=
 =?utf-8?B?TkduM3phbzBMVmlVVWlTSjVva0pURVhtSHIrZVVybkdJaDhMUVhqQjdZbk9r?=
 =?utf-8?B?c0Yvd2gvTmwzYkMwYTMrdWRtajNNNUNBM0hMSTMwdkpCRktHb2JMbWpMUkFl?=
 =?utf-8?B?RE5UNWl6RitjSkh4R0ZmMEFMcmUrQ3hHdDZ3QldvWmZaWHQ0TC9PbXJsVDdq?=
 =?utf-8?B?VkMyaHYrVzlKQWkyR2R1Wk5kd3VNSFd4b0hCOVpDK29CL3lXcW5sQWN4eHNN?=
 =?utf-8?B?WklqellIbEJrSkY1dmRXNkZHeTFkV0RvcjFpWXpPdHAweUVwYU9ScTh3OUdv?=
 =?utf-8?B?UUUzYTNDdlM2MGJWUlAyblJVVUFFaHVYNTFrUjlhMG9vSmpleGJnRUY4SDdV?=
 =?utf-8?B?dUZtVUhBMXlsdXUrSUhIVm82MjZqR2QveDI0b0ZSMi80c242VGcrd2tGNjdY?=
 =?utf-8?B?MlVveU96M3NnbjRJVHhOSG1JQmJrN3E1NXVRdWZtQmRBMHlRVmdOcFVpNG1G?=
 =?utf-8?B?WkMrQWh5MTN4RjROdjEySm9ZNlZPdHBJVFBNTDBpVlltTjVNQVBoeE9PYlB6?=
 =?utf-8?B?bWRrWkxHa1VOSjZsV0xoZVpjcHVicjREdW5ZeW1CUnpua0laM0diNWd3THg2?=
 =?utf-8?Q?dhDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXpsRlJXZGhDckF3aEtiYWdwY3E1WDQ2NDNDazRDK25DT0hndk1oaS9lSHhO?=
 =?utf-8?B?SjVtVTFuUllKNkcvT0x3QjBHMDlYUEFZaXZ4RWZGVzc5aittbWhCQ0wzZDU2?=
 =?utf-8?B?eXBqQmVJc2lPaW9ZVkdVeGx4RzBFdFlWK1B1RGZsVXo0R21iNjlmMkJYdXVt?=
 =?utf-8?B?Qm1JM3FBQkw4SnlPRGJOSXJIRWNaRzdFbFdJaWE5OUNNNzU2bGk3RHNnbGNi?=
 =?utf-8?B?dlc3L3JxSUw2Zy9RZnAxVWFabFZiZEVKQm1SVW92dWM3OWJMTWd6a0hNc1g1?=
 =?utf-8?B?WCtQcXVpbGFkRjdLTlRyZjZMTEZFNXVxVXpGbmk3Q2wwQzFrV0FZQVU0WFJ6?=
 =?utf-8?B?V3dKS2IvMGZteDQ5YWh4MWErdlZ6Q0dTdmJJTjBnWFpUeWJvVTQyQzR2OWpO?=
 =?utf-8?B?S3lWbFQzMEt3UW9NMWdyeDBSTzU0RnFjL2dvdE9CN3UwQ2NtUjA1a2YvMUZY?=
 =?utf-8?B?aWFneTl4cWVyNEQxRGxSNWdvS2E3NkJ4Q1JNQ1hyVEpOTmp2SStDc1VwQ1JS?=
 =?utf-8?B?amR1RFdHdW1yT0FQbXdyazRpN3ZWZklPV1hyenpoN0tsN3hNSkdwWmFlU2Nq?=
 =?utf-8?B?SlJKVlhZTTVBV29WdDhCRXFEMWlaaHNnRlRSMDY2RWxaYy9oM0E4bVltMURw?=
 =?utf-8?B?Z2VuOTFjZVVkdFlrUFVPa2xnVkpVZWdoSlpYU00vbE1zazA2TndWVE9BRU5D?=
 =?utf-8?B?blFZZFZDZlhSYTh4dzJ4L0VCOEZrekljMUJyM29STG45c2IzKzFpSWpqOEFi?=
 =?utf-8?B?dHJJbW5TQjltU08wbmNLdm5CbG5DWHVaL1V6MXFzK2p4MFZQMC9EdGF2Tm9r?=
 =?utf-8?B?NUUydHJiMGUxQ2hrY244VTFocmJTZjRTbmdTZ3dMaVA4VENWWmZpem44dWNt?=
 =?utf-8?B?TW9JSGpGMU5HcFRncWZGK1RKd0hqVUpYY244c1ZsalNyT1dEOFpRRllGQ2lL?=
 =?utf-8?B?WlBhNmVpb1NReitVNWYyUlcrci90WnB1Q05VUWs0K3RWMU5jY05IVVQ4N1BT?=
 =?utf-8?B?YjhLTHNlWDNEeGtUYVdLQ1Z0YnhnK2xIS0xwdVF4czEyOUJwS082T2lFdXor?=
 =?utf-8?B?ZU5KYWNwZGJoUHpXaDhQeHhQRXM1NStnTEpUMndkRXZjVXFDaW9HaVM4dHNK?=
 =?utf-8?B?ZUUxejlwbndFS3VPM2NaNjRla2VmT0FuUk13N2dPUzZCUHNsenJ4WGlzRnVq?=
 =?utf-8?B?WG5WbVVoem5Sa0o4N1RhVXlwTjFUZm16aThkUzE5eWx6QzAwMlBBL0F2Ukd2?=
 =?utf-8?B?YjhkZTRGNGlWYVhzRkFySVc5T3pnMXVnTzVBTEN0Q2RweDFtV2RxcnhXbDVo?=
 =?utf-8?B?UUY2Q1BUNENkU3JTdzlMQktUdDhNYjcvckRnZE5sQU03Z2RVOHU0c0NjV2JK?=
 =?utf-8?B?MXJLNzVBazBTMjY3cXpNQUpydk1Gckx3WUcrNjZrMmdTWXZIRWF3aU5jV3Fx?=
 =?utf-8?B?RU1MMjM5ZVBCaUs3R1I2N0ZrQVJWS29UZEJRN1JKa1I3R1pGZ0ErNnFKSkpm?=
 =?utf-8?B?WUdOM3FZNXNSRFRDZk9RZ1grbnpIU241enlnN1JycTBVbE1UYkVUZ2pQLzh0?=
 =?utf-8?B?bTU0ZXVZR0dZYmxJbHlmK2pRMHg3Y0VabFlOVUZzSy9GcVE2clI5QlRKcFRp?=
 =?utf-8?B?UW5PVnQyQzVLVk96UFVUckdXKzFER01EUC9UMWpCQ3E4eHp2NGN0Mm9wTlBM?=
 =?utf-8?B?M3VRVnFLZnVFNHF1dFUxRW5lQmpQTEswMUkrMlB4UWg5TUpNU0ljbDQwcEF4?=
 =?utf-8?B?MU9CVjRtYlIzMit0VHFoWWs2SmdWVEk3MTZHbWVFaWtUeHFKeFlTSFB0UU9P?=
 =?utf-8?B?Sk92dVRaRk15QTRjMy9reFZXNVZSeDYvRTlRdUFWUWZGbFQxU3JubFM5RVYr?=
 =?utf-8?B?UWQzQWFGUXF0TE54VXVEMGg0VXZKSm1UczF3OVlPNkFmdEo1QUpsNkxMUW10?=
 =?utf-8?B?TjBqUkRoeWlOKzJQZWZ4REtqRHVlTVFhUGxjU29tbGtXN0JkOFVkdjVCV0dR?=
 =?utf-8?B?THhmUjZ6K3VOM0p3U1A3cGVTcEJCNDJ2d1FHQitFcUt3MjEwQllTTTduWjND?=
 =?utf-8?B?ZjlIcnNLblU4aW84Q2tUTHRET2FKWTlBbHFPb0lGZXRQOXF4QmlwYkZKcUo4?=
 =?utf-8?B?eWR0aSsyeStpZ0NWOU9XQ0FoTUl3eW15dW01MTNURWJ3N3NMWHVtVXQxWHFv?=
 =?utf-8?B?M1pxWmVYR296bmRHUlpVQSs1dWExQkFyS0RzcUxoOXR6eHo2QS9zN05JaXhr?=
 =?utf-8?B?UjJZOVBPK1Q5ZUxVRk41Z3IwVWVtYUtLTGp6Qll2aWRMMWI0bXVqOXR3eW1s?=
 =?utf-8?B?Sys5NmdkMXJ1bFdaT3g3NmlyVjdnVEtzckpjWmFCLzdlR1dQS2M1MVpPdjJp?=
 =?utf-8?Q?6M5zYeLtVeCX5kMU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HKHKkJn+f+fVgZwOgjw6Oj+nrvfeNQ2Jpz5Cqe6M/62+rCDlOueFsC2LdoSIlWfmHnGxQv0jTdFQOk6NgZ38Nagie3V/Q1e2tuHrYWqWToFsANtUm9M3bpM4+Y9jNRr8AHYIN2XosBg5Ac8I+x7ieCpZum3YLiVIGLA9ffSauFIMull0JOj+e/SX4FKai+0eV5x44earMRp5mbKhduwEo8zCJVaMwkzm5v1bT/IVumQmOZOpaTmU5XLJ/FMTv/Lfsn87S7Vm88fWxJczJ6jVw/t9dwwqPJJx21q80wRnHds6E2qZjEO9Kn5NPyVWnW1zQcBCAj4GQXuvsiy/pztKn66tO1JqV0RXYHjrVJ+y0LrZLyPoJ1L3n/K2KmaWMAeYjQjvMYipywRiCDdRZT7G6LaDa4pj0X4HYEGow5DKRam9pWWgirUs3Rbt0oYsSNsSUM+5ABg8LW3/mzJzxup5yFoMEa/97ZsXWAi1FkoLF5sFFRgBMMFcjmfuDQ0QVfblj366Ye7Yf0d2g0R+TLoyQ3SQ8dm+Q31INZ2trX03KW7WI8MS2NhlDJ3/QCv9CgqJmmia+C1NQdZ2YxAtnoUrL3RKBcl8jVZLYSHXe6vep/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf934cbf-01c1-414f-bf65-08de5a919fd9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:11:03.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrWWFAL2sb+0Nz9pLDOWsj2B+J2Ivw/oD+4VJO5aQxHiQzfgOe9w+ETDx+J+4rXWMnRrpRJK/9uOptdu5DfHt/hSGmpWR5tz7pd9fN6faVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=961 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230118
X-Proofpoint-GUID: XteJnpijX7BBYRiMXsrXKiWWJzq-Saxi
X-Proofpoint-ORIG-GUID: XteJnpijX7BBYRiMXsrXKiWWJzq-Saxi
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=69738f90 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=RSkgPbYOZ3NyYxxeYKgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExOCBTYWx0ZWRfX6RKT6uSfgMSA
 AyO27iqLIdmDQzaEM3FtYzTXtBbpHzLZHmVkhsNsA8mdenEYZ0SLUSquQj+URxg9dFqtV1P/rf7
 O61bsauOVqNp5d4UIX1q/kOiIitz7yk6nk9h5qagf6hBqCO+gdl9s2Xk6O1ajhQsytYni6XzJJF
 rQvEeold6SDUa54NrN8euB/7cWY9vMQP0nfl/VVoyBmIRZ9BEHN4Zs1+Mt0vLalzT0grcT/MJ3C
 HnzEcXcc3k88jId9QRkoNmxEo75glnU0xR0d6Splv6F+aSd/ir9Pqia6ybAxubM55WOowQPgEvd
 QTNvmYJr2/mzJJ57eVT9aYVLr4jt78P+1xm0NP5SSwbsm0R+3FC9vxUVuoWrUdtwgoFL5VOVoSt
 Bnl4JMRmQ8c+joZSS75R8cgytzPp/65cRTbOfdgh3oyfOeV59gJhBy8y3emx3Yk3XSDGRis1rcE
 G+tiUEND86mtiNuU2WA==

On Thu, Jan 22, 2026 at 11:39:34AM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 22, 2026 at 5:02 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > We're doing precisely the same thing that __vma_exit_locked() does, so
> > de-duplicate this code and keep the refcount primitive in one place.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>

Thanks!
