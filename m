Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476034D4C2
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180430; cv=fail; b=bM+xJS9lcXIf3AnaybzOorKLW7Yf3TTaZSOTM1bC8Z9ZWD5uwHQ+3e/V3o9sfYwy4OYnfTSJMp6sSIC6gqwzLVTt59Q66ignq//Tm+IqUEuSfg9ZwGqreveitHcFiA9vQJv5h0wIUwL/pcA61xzb5yyWealYyqJDVslD1eoiWnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180430; c=relaxed/simple;
	bh=3quXa21g1GsK8Skg+FIjyRPCyDEH4C7wQJVB/aT82SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtE4SEX1Uvv8bYsnXrEOVEJ1I96KRQqmVeCRhd5Wo9DXjDLeRzkDex87USLO3pnTmi3VmSe1I3he8zGVZQr+cPV0TbwFZzpkrl9Qez+D0hsxrvqJNj/3N/xKBdOdiJQHPjySVjF7lXgogsK0gwgMKGAfp0vxeiGxqJ1OlNG4Hng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMwYbUKQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xk8+fVMa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMwYbUKQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xk8+fVMa"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N3EBDE2172801;
	Fri, 23 Jan 2026 15:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3quXa21g1GsK8Skg+FIjyRPCyDEH4C7wQJVB/aT82SU=; b=
	lMwYbUKQsG0jJJHoUi/OBD/HeLlsO8KHtKKWcjeWYAL68NLcNjbONiTOacWRzONV
	oacunqYvLfBPs+19NM08KhPOnVJ50RIeOvRH+6cg0S6fx2IATYtkqqSmJg97/RnK
	Gk0ZgwLO/mZ7J9uITDl06KGrkflXRQCVnh5MI2I46B+WspfgqG0aIlaRiF7svyFA
	qbKlS07N8nM/YDBmsEXOU1j6Dn1H7pdl8CMHVyFqg8KYNrkDZ7sL06eKC1UcDRt2
	jXbCUX8ASlDoDGurLxX29XXFyxuo2C3MppeWQrl/IxyPioEsW36U05klX/WzIXDY
	son1MWRGpwocDET/Gj1N9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd71bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 15:00:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NCoact032918;
	Fri, 23 Jan 2026 14:59:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvexf2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 14:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcbQy/XfGkRnSDORIq0qHU44dojUy10dlwqBK8XUNx+oJfrJ6GA9GOr1zW3JLeQsnUC7yk/KKA6u6M5rMwpUNYhsO86ziD4iQhzlpHqhInAXcIPIF3P7o6Q0k1lX1V/+wSR35epGrOyZeJlZvZmFnYGsi8yK4xgBVsRTUwQlIy4Up4MSYFWtdab190MxGzKKQ8R7bYZSpmjA/v26wmzZi8Y36Hbg0YTXeRicGKyuQSj0XGRcOE+aOWuh+g+O7f+XkS0wLPbOC6dM51q/Qg3D5V/kFX9+2tZ4QFjMAAeGPLU9Wd/2T/l9XoW+TbqM1OaYxjX2STnodh2pE/fxRwB3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3quXa21g1GsK8Skg+FIjyRPCyDEH4C7wQJVB/aT82SU=;
 b=fsIYQhbl0WYQ9tCMKoJWZ7oJ4yoifNcS/kqx79ND9pK9Fs00nTDLPyEcdTFqXh3niBgEWK0YVTXthwowByDSeh5FTt345s9kQFKCV0J9Bmtx8ymp9GbIahCxOPF3a3qsg8nHjd9MLbXN6w5m55rFQNWp4GyW+7ZRvoM19jm9FcCMSbNom+WbuBtsrf61J9F52KJ2m8wR02ReI7s3p+JfrfNwqb3XWx/ma25DdolVXAjGp/4k42WC/338w+Mj4BO7zmniJE4enA1oTFgGGDOhArfizFoFTrbpo6OLa32bxT5+l+MMiizq6lQ9tkd3R1gRXmU8KKHIfNlIDV0olopSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3quXa21g1GsK8Skg+FIjyRPCyDEH4C7wQJVB/aT82SU=;
 b=Xk8+fVMaF/FQywXBxuePJCJ3M0qNJgvVa5LiGlha9ukW7/cwTy5EoAvWD92RfG95Z/Xs2NkfK6Xqh1qBuqHpl5CYe58Sw3qokAc7W7aO5r2BcVTd1bsmrDsqyG69e8dSQFGCSqNONtwsNe51QwK8kv6DmkB3anblj7P8EvUbw+0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:59:57 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 14:59:57 +0000
Date: Fri, 23 Jan 2026 15:00:00 +0000
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
Subject: Re: [PATCH RESEND v3 04/10] mm/vma: add+use vma lockdep
 acquire/release defines
Message-ID: <f7352c02-c0c8-4ede-acb8-aa440860fd1a@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpG+H=gRSWuhLL=NHQAQzrbF8Jku2qgRHv1moLPRibk5TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG+H=gRSWuhLL=NHQAQzrbF8Jku2qgRHv1moLPRibk5TA@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a1ce96-9490-4860-80b2-08de5a9012ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVdZYnZqWmZRUGEyY2lJdHF4blY0djhjNFVuUEhOWnkvWjZhZjIxZVNlVENm?=
 =?utf-8?B?SFp0ZEpEU2NFQjIwSjBzbXZ3TkxPMEpmNTk2bU9FK1dpeTZPcE9od3BZazJM?=
 =?utf-8?B?dGtyTStibGMyQW5TaThabGRpc3Q4TzFOVGJxS0l6SmdkdGx3UmZ6czZXWFNF?=
 =?utf-8?B?VTlmOGt5V2ZkOFg0WDBCbEh0SFh1ak1saGVVdWpMRTNDbWRITHlNbnM5ZTNE?=
 =?utf-8?B?SDVBMzNmL3JacDcycFdnQWZhc3dQWU56NHdtVTNsSjdBck9LUnZmS0FMblk4?=
 =?utf-8?B?bWN0VWVUNFFnWlFDODV0KytORHh6UzlJa1ZzU3Vxb0ZCYnhkbldiT0x2SEVz?=
 =?utf-8?B?c2gwc2hNZ1JQdGhPclBseVFSL1Jrb1JyaUR3UlF3R2hqcHREakJ3SjRNVWx2?=
 =?utf-8?B?ZVBHaU52SEpaMWt0bDlVUXljZXV5VjBwVjNyTTVvc0V6enBXVVBQTGhGbDUx?=
 =?utf-8?B?WXZQb3FRM2pCSHQ3NVRia2FBcjBmbVR0djc0OFJtOXdkaUJLZ0huM2FqUGxD?=
 =?utf-8?B?cUFXcGxCYzlLeU5mR0JnL0ZQYVdQQTlZRTFoR1IzcVdGdmJ5UkVhV1FUaHhF?=
 =?utf-8?B?MDVSRXU1M0taSTBtdlZXTGVwakljdnQ4MW1ac29tSzFPTVZOeUtSKzdhMnVy?=
 =?utf-8?B?Mjl5VWNIK0RkYWJ4Z3NwT095cGFaQ3lySEc3TTVwZ2JCMTk3VUEzWEM5NmY1?=
 =?utf-8?B?d3ZPNEJlVzlBeWlkOUZkTXUzT1FoWW1oWVdIc0hpcFFOeHp5U1FjWWozWkUz?=
 =?utf-8?B?VU5zMHMydkVMazEzNXp0N0tKOVU4clMxemxYeXA3SGhvQUF2Tk5vRE5BdGFL?=
 =?utf-8?B?QVNEWGRZVFBtY1kxMnRHRDlUYWFSQ251RHMzSCtuWUc2b3BzOVRRb0dIRy91?=
 =?utf-8?B?QTBQZ0tZTXlCa3p3S1RXQ2JLeVdOS2pjRkMrTngyVFNIRk5zQzNpeGhBVkI0?=
 =?utf-8?B?VVJaMWsyeEVYdk9CVFMvL1RhU0QrQWFzVGkzUUExdEZoNGd1WTlYZ2ZUUG9T?=
 =?utf-8?B?V29MdUxpNkFhNk5xQlM2Wk13RW5iZTY0S1cvVWJENXZFTVhESzFxcysyeWFO?=
 =?utf-8?B?T3pJbk41S2NwMWxqZVFOTFlVWlVhMlo3SEl0WDBEOFM4bU1Zcy8xUHBidEk1?=
 =?utf-8?B?M3hzMDY1RVl5L1FDdlN5STZ1dndLeFVOdlNXTzVVY0s1U25PSlAyUHlLQ0x6?=
 =?utf-8?B?K3VjeHVMaDJ1SUZGL050aFhOK2Z0NFJBdGpFT3phdUx6aUdDa2lSYnBIRE0x?=
 =?utf-8?B?cTVDdTRLRDJ4TlNCQU1PeU05QW4xaGViRjRlaWdveFZmZnJiOHNTRmlLUzFx?=
 =?utf-8?B?QVNERzdPSmw5emNFM244VFRaK0czQXZUN1hPSGlsdE5lRitWOHdnaDBtTnhJ?=
 =?utf-8?B?RDZxeGFHYU5zSlRSZlpoWGxNTmlmczFmTHBhMURuRDJEY2tXTlQ2QkF6TWE0?=
 =?utf-8?B?Qk5DOE5zblVvZjREekxob2tjWGI5VzRsK0NBMzByM3M0bzBhQmdKemRDamVS?=
 =?utf-8?B?cmdrZUx6UzA0a1g2TlFwQXJyZzEvSVJlbStHekl5RUpKK2xhSEVRWjJscW1J?=
 =?utf-8?B?ejJBNndZdklCcTVud2Vkb1VZMGFKLzlQcDVkcFNGQ3VkN2laZUVWM2loOUx1?=
 =?utf-8?B?UnlHdWY1T3dqWHl2QlRxQWR4ZGxiWlJndEhMWjVDeXFjcGpnUU9LTThjc1JU?=
 =?utf-8?B?R3lDcFc3QWxaK3V6dUZpeW5tc3ZFV3dsL3ZNTmhzMFhHRGg5Tjd0Mm5FTE5o?=
 =?utf-8?B?WVVGR2N6MVNvdHI1OHRnZC91YXQzanVIWWlDNHRJWk9NTEtoMWRQeWJLbEFw?=
 =?utf-8?B?TDU2bG1xMFhKNC9sK2lqbXVERy91Wmd2eGt4alc5ZDVXaWIyZ3Myc0EzWEgz?=
 =?utf-8?B?WHRrMmhnOXlqaUREVmkyNDRtS29rdnNTTGhnUHhNWjhuOVJ4TXlsT24zU09u?=
 =?utf-8?B?VVJlQmxQb2t3TndHVXFPUlRhWXZHTnNlaXR6M2hSZDIraW9WNmZJempnNXAw?=
 =?utf-8?B?VXhHWXp0TU9PUW1zZmFMNm5iazlMdG5kNHhmOXJuMkl6blFLQkJsWVo4Z3Fh?=
 =?utf-8?B?emZFeVU3UFB5a3p1dDRvTFNoZE9YUENNT2pTSVlHanZyYWZLTy9QSjJ5OGcv?=
 =?utf-8?Q?6leQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHRRVmRjL0VxYzk4L1NkSnh2Z3FXV3o3dFEzbWZmQmRqY0ZidnhUTmtsSzRo?=
 =?utf-8?B?dmJhWmloOUNsNGdsaWR4Z0NES2FpdUhibklrZDFLdWpIa1NmMEdUM3ljZ3JL?=
 =?utf-8?B?bVRUKzFuMG5GRnI5R0NEWUpxK3RaR0poaFBkNlc0b1RqQXo2UlV0a210OVAr?=
 =?utf-8?B?cHJDZXAwOHlMY2kya2NtYWZBY09ERUtFaHM3ZXRtUkNTL1BZdUtCQkJvV1Yv?=
 =?utf-8?B?Y2lza09LZ2pEd1NpamtVdWxLcmhCVDlMcjhic08zMktYcUpDYXhlcktRcml6?=
 =?utf-8?B?TWFKbWREUVhJdWIyWFpjdnlEUWpnalBZMGczbjQ0bC9oS21kSUlVV1dKbEkw?=
 =?utf-8?B?TExDZGZBQWd1YmFRWXJxd25mY0NheEJCQXI4RG5tV3JINDFDc2RIQ2VMbE1R?=
 =?utf-8?B?OGJZZnJGVlZMV1BkZjBoTUxrTTljTnViTWIrNzUveWNhK1AwU041ci9aajQx?=
 =?utf-8?B?QkQ4bzdKSnRWVEZBVXJWMTZvNzl1TlVBeXBxeTlZbVBWVk1kejBBdSsrTTht?=
 =?utf-8?B?UHhrWGJSU2JTSG1oY1U3UjA3MS9Mc3ErZDExTzI1ZjNHS2puS01QTGErcHMw?=
 =?utf-8?B?TXBsQUhNQ2VodGhOOXowQ0gwL2RFekJveWJuTktST3habDh3TWJ2ZlNoZzdF?=
 =?utf-8?B?VHVSMDZvR1d1bjV0aFNWUFFFVlJsb3AzMituTXdFcnVPYStHM1pxeXR0aWFN?=
 =?utf-8?B?UXdMVThUcFQ1UWg3Y0dXQWkwWkx4VGo1ckVhcG5rMmZINlVTdTQ1REx2OGZn?=
 =?utf-8?B?N2tNcXNlVExteGZwdVBsR0x4TWNzTUp3Tkg0YmZKdFZNWGZzNGFvOEs0NTJT?=
 =?utf-8?B?WFdkcjhzbjFCL2RBanVwbTYzT241SEtjZW9jZFJLY2J4QzNIczMzQTBMdkNS?=
 =?utf-8?B?YzJ4a1F5b2Q0UExyYWpsZWk2T1ByNTJMM0JMUHZodWE0Y21sTTRaU3M1OHdE?=
 =?utf-8?B?MjRuZXBGYlNWNmdYUmhmUUhYS3h3b3plTTNNbVBjaEhjRWY5clVPdU9JZ1Q3?=
 =?utf-8?B?cGQzd1UvNk9BUk5hRVJYV3pJWUJhM1V6b2VuSktYU3lFSTNxVXQ3V1pOSTZ0?=
 =?utf-8?B?djNjVS9qYWwxRnVOY3J2RVJ3Z2dDcEp2OHM3akllSm5BWldUdnZFZ1Q5TjIy?=
 =?utf-8?B?dEJvWWZod1lyWnoxbTFXZng4Q1VuT2ZiQlNCYXpOdkRCOTArLzBSWVNGR3cz?=
 =?utf-8?B?dDJvWTBGeENIL0c1Zi91Q1g5K0VSZVo3VWRibEljVGRKaWgzR0dXSEJIYzYx?=
 =?utf-8?B?amxXdkRoV3VZdk5TM3RmaUJ1eHZvTzdMSmZaYUE2elE3c2taVFJGcmxwM0dQ?=
 =?utf-8?B?YXpwNS9qOTJDcE5XMWNqeXQxR25Wdm90T01sNVRBRzIyTGFMV0FBV2V4UkRI?=
 =?utf-8?B?eEt6amZXQ3o0Sk1ibmViZ25CNk8zTjNvQzIzOTlqZWxjWEhuZENmbkVGMVJt?=
 =?utf-8?B?bkVFSWdGNWd2ZUVmNGF6WWVTQzFQaytFdTVmWWtSTzJaZ251OElteXk3Tktp?=
 =?utf-8?B?MUV3eUNDTFRwOGhhUXVrSVk4cUhCKzlXcVJrK3pLQmpJNGRiWkhZMUk3OTJM?=
 =?utf-8?B?R0tRYi83bHhCdlJYK3g2S3o1enhac3FDcWVyYStaemd2ckZ5UVk3Wkt5bllH?=
 =?utf-8?B?dEZvYzB1VTZqK0JJZTBvN01GeXNmSldLSExVRzhMUEQ2RlExdjdkdDBjczJG?=
 =?utf-8?B?WTRiZUxtaEN3bHlNbzZzQXNGNU5yQ2piQU5QdlZ0YjMzRjZDM3pqd3I3NE9V?=
 =?utf-8?B?YncvWHJ6V0k4YmluWkI2T0F3UDJ2TFFxN3RoMW1tbmxQQ3FmYUZ5SVp2Qzhv?=
 =?utf-8?B?cHFtRVRYcFpMSUc0TzcvZEJuaEh5QmQ4dWo1YkFsTDFOTHJ0WXNvOFd0SFBK?=
 =?utf-8?B?YmszQ0JFWlNobE9UbXM3aE4vZnY1SnMyV1N3MEFyM1BsNENLdmo1MGVEblZ3?=
 =?utf-8?B?OEM0aDJwaE1CRmlHdGxqOS80OFJENUNIU3BDTGRJTktXaThxeGdzUzZWME5R?=
 =?utf-8?B?bmtlalNsSWxmRDRPNDA1c3lPbXlEWWVXb3lYRE16RElZd0pxclpnbFBPL0c1?=
 =?utf-8?B?ME1oZCtpUGN4bHhIWjY5UHdRYkNkSC85a2F2dEh3ei9ZdDFmMjZWNTc1WWVT?=
 =?utf-8?B?UkMwTTVGV2Y4eGY4eW5Denp6ekc0NTAwYjZ0Wm5RTEoyTDgyTTVCUS90cE52?=
 =?utf-8?B?S29BMWllRlc2ekM1TWtZcFF5ZzUvMnBlKzd6SHg2ck9GMEJEbUNJOU9WcXI3?=
 =?utf-8?B?RVJ1R2xCL1Z2MnIrcDhrYmdsZm1BNUVyUE4zMHlSVDQyS0NxQjh6R3EwNlhY?=
 =?utf-8?B?QmRoS2xlUGtqaDNZcmZjMkNjekFpQkoweGRDeTBBVmEwVWhBZ2ZYR3ZSOEJw?=
 =?utf-8?Q?dHbUz+acJ4PTMpp0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OloD061mv6gT7AcqbNlt4SolYGNQpNyndnTru9hE46JaqhlHBRNNr4U2Xu8FMhZ3qD+6d3dsfJVsWUrVjNLOVvgsjgJY+1ncZv1dtL2pAqTunnEocQwpL/fpJ2+Z2pZ7VpobixDG0dny3bbBaClmPvWMbjoBFQZ0PkzdpNcw9aNjfinmP9EgErGOFHHeJ0qysUqZSs+Ubduhtmd6jPcJ3PKMHaZO9HvVaqL5kxoMu0I+k2cqApx3Zx/vbaZe19UJqWzf8Y85v70uIaHHkNDMyiciE2Nyzx2l39PZllqQabhgSRAD9vXIuVniarwvJkuU2cbg0a2nFTpKNCBXwO3gEjWbbfVPfAhuFve+mQdkK2ufgtHazRGbVb/96tFfPpXFbKtx9nqtjR4HkOcTbOKnxk4KV54roMMOxNsq6zCRemuof5IpG1XYBg68tKXPyYAyB8ZLpcbBGbMYTumNhF0GgDJn/4JIDtlPiUO78QV4SKBY4Xf3QmVMTipKNepyhVyVhIMVNB3OVCnPBoHs6xq84bM256whmyVetvvfcoMzziA5PMTPwfAZRLzc5oFRQcT1ozykKrYe7Sv1yTuFzW3PXIUegNK7W4WBDzT9ZrT5u3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a1ce96-9490-4860-80b2-08de5a9012ac
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:59:56.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNrlBW1Duz4+Y2xYZAzOd9jy3BfQmOeGW/2bI5xa/K1g9xoFKfak8SJF+RkhNtDIrrJsyWTpe0vWgyHDttAnoACc6BtofeaixkE7qZz3AD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230117
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=69738cf0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=fpcF-2teMqrY8f35BKgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ByeNLHY6vyL6bHJTFsWsf_0u9PjXKv_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExNyBTYWx0ZWRfX+IjO9f/gxJpX
 UIt0uEpEgzRHVHX3nHG+Wy99lB/vLvdTLkJBrpPIdY9bcceIPkQUlK8WsWJqiCgXSHU8wWB0zN4
 BwIULrreyNo9gfQGFzmK4fQA/o5rhWQD5b7zMijMqzlWFEooM9vfW73Mjs5eBiE8Tg3KjtEuqXa
 LksM6aXFQMIdLerVBiD8L29uexm/2P9BsAfga8dY60B5zoVDnFtzktUDvGiYpoSxHFYFcgJ8coC
 n091nWX+Jf6X//ZWj3FxLWFA4csB94nJROz6UqgCNmmBYERdgxlqagdHSPpuCmjQu1BDWXinCTz
 BhrW9rkJepgnleTSyXN3uR+8UraqgCI7fkkAuV9ArZoOs4X1bwUw7REcNHHTGXRX8XspZJsk2gX
 PuTizvthaa+5wJDk094uoYaHkkfAW4rGswAqvy7lepmKbJhKJIkf1g+W204d5I+cmsAoqg+aM0c
 nYNO8XPErWUKi9NHE+w==
X-Proofpoint-GUID: ByeNLHY6vyL6bHJTFsWsf_0u9PjXKv_f

On Thu, Jan 22, 2026 at 11:32:17AM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 22, 2026 at 5:02 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > The code is littered with inscrutable and duplicative lockdep incantations,
> > replace these with defines which explain what is going on and add
> > commentary to explain what we're doing.
> >
> > If lockdep is disabled these become no-ops. We must use defines so _RET_IP_
> > remains meaningful.
> >
> > These are self-documenting and aid readability of the code.
> >
> > Additionally, instead of using the confusing rwsem_*() form for something
> > that is emphatically not an rwsem, we instead explicitly use
> > lock_[acquired, release]_shared/exclusive() lockdep invocations since we
> > are doing something rather custom here and these make more sense to use.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Very nice! Thank you.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!
