Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7A314D15
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600952; cv=fail; b=uVlCTT7BoPtDbs8Q2Fo0m845SFCTe0LkjZ+LFUzz7TKvCIcORH89yxWbG2SJqMDwwFuPg/gjhebAlomifYEpKrZp4Cv+HNu42KiWGNcvMUkZBKa2Buwu29OxsiKRKm/mKtZAw4jn3bhJpoB4cyYWAA2cOvB/tTBqez7Uo+KJjis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600952; c=relaxed/simple;
	bh=aBYMeeElhHAUS0zhvL2sGte3/6ApSy9kPYtcsAdPgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FsVRTjaWlIiHdZqu0yi1kMxzYnV+hNlOZntJqF+N4PjNa87o44Xav4mZoH5hUx1HHJ2S4p5Rm4cfb59HtKYLc4D5G9De5EVCNzpfIAnstKTpisv1vJXrKO5nAgPs6LhFqCdRTOV7yYzK5tSHde+wFXhW/y1/zHAteJp3BDv/w+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKQh1rbo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MnVParZe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKQh1rbo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MnVParZe"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4CLfA838156;
	Wed, 28 Jan 2026 11:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=64/caSNKRTC/McCpG408dCr9L9ckyCV+wYKCx+bxr/4=; b=
	JKQh1rbo0Wy+2oN2hO2+JX6J10454BWj5Kfu1oaHhlSoXLnMRG8wJjxPxxyS/CPx
	2hlfNHW4lhZExhxtk+JPAXCppYyKW3wTQ1YmYGIsrPjvounO/g2yaPBNZociZfOf
	nwUcAsI+mSC+FoN89bLLN27+ewXPSYjottZKZj1dH817cPJ+YgDo0njqNYzDC66Z
	91cKG9lDNdF/pNSnG7UbLWZMQRumOltjWaMRaJUiAbvbsMEJn2ps1q1dmYB4JU0e
	9sZqQxcp6kNYeY1kUZQOrIXDkdtUZFqwwyTyVclxtjpk4thMtemUasuHjhXTNqh7
	o9ZmamrmllbkFtsO4UYVqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378h7b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:48:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9t7P3019774;
	Wed, 28 Jan 2026 11:48:28 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhg3uay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVcSPdqFuJAsk44kM2xEdTSVUh+v1tOEbACgBMH8C/lA6++uu4c3iVbq8V3ui8KnwAAx5iIhtXMqM1DAG31ECv7zAAHitmXv9xfjeOawgEQCKBBdIbML/zTNgHPYnA+ed5Q9P9/1fUmia7e989W8HJ9Y1ek9Abjh+mcXi6+uFbSun7w8xwNm5RrrPRGacuv8SvNisMOZqzVQ2CAibOSFqlWom433g2aUTy43fKYLCBQE25XDwuQnrL7JCqr9LKSt+6TvLBy1UN9GrRp+au+2Vc2Lxki52kWgKoqtVXMJmGtHbk51W8zpekZH1iqFN5pZPV6NeuzIAMwktynsY0ANvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64/caSNKRTC/McCpG408dCr9L9ckyCV+wYKCx+bxr/4=;
 b=UGez20UyCf//bfFZLt/6puhLtHHGWLumR7KbqtleuIcYEGFgSerOi2U72viGRU1q796QLDvNPjpnECpB/pOfVAy6EoD5FVp+6QlkCsQSS/N/xRBRGH6oylLUMH5gANkRcdq+JZeZYEH1SgGTuDzupSJOIN8YPYhPyNojsgViKdVINaGiDb8aHWpKlHGNx5pezvyGD7BlYFY8IPVf+xl2g8YV7Hj/bmsEUde6qbX1iW9Fxd3AvyLCoGeySRgrEmBIqnrBl36hjUZYXjimyl3eoUNs2c7s4TUsyiYCc3yZdKT4Z4jycNz0W7wbUb2OFuPs992/etKuq3CeThd+xSCgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64/caSNKRTC/McCpG408dCr9L9ckyCV+wYKCx+bxr/4=;
 b=MnVParZeykJySLBgllp92V2XFzo/uTdadq79NQEgaYbSHwKpaN7UnCqiyb/zROzGduvlpQOQfgL028huhl/LXXON1KS+1WAF20OrFx6GIO4Z6rbUN/B6AoJZmj0apAt88aCUdeP9Dr75Jt63bIEay2ZOAxwPJakK0WImJSMtFJs=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 11:48:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 11:48:22 +0000
Date: Wed, 28 Jan 2026 11:48:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 04/10] mm/vma: add+use vma lockdep acquire/release
 defines
Message-ID: <71c45f74-0fb5-4ec8-aa67-d700df94b617@lucifer.local>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>
 <20260128113749.osNjwNqo@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128113749.osNjwNqo@linutronix.de>
X-ClientProxiedBy: LO4P123CA0614.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b179b5-dc3f-4140-48d8-08de5e63237b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmNWemk4dGYrRmxjdjFWYkgreFpUQW9RNndCbGFrNHl6ZnVCeXowMUtKSEFR?=
 =?utf-8?B?cnBSeWMvSjh6MFRod3gvOVJZeUFSbEUvcFV2QjBCZVB0d2Rwd1lRN1pDTXNT?=
 =?utf-8?B?TmhvK202L1pYUWVDbTZwWmNFamJmVXI0SDROaU93STg3RWN1eEVJSDdSY1hC?=
 =?utf-8?B?ZldxdVE0eWwzWTZiQ2o0cnVVWEtwK3hUOFgyK25BTC84QVNjbWMzZmJ1NXNE?=
 =?utf-8?B?Y2VuS25EQ3lGbjVnS29FZWgzQTlZeThMOVc4RmRFaU5JakY2d2xiS1FPZDB0?=
 =?utf-8?B?ZWc4Y09ETUxUYS92a3BvcG0zYXpNcC9RV0VSOTR2QzhnNU5Fbjk3ZzFaa09W?=
 =?utf-8?B?Z0tnL25mcXVoNHhhclFjdmtiMWp0ejY4U0toWU9lNEo5NEQzRWc4WGRFak1x?=
 =?utf-8?B?WUx6eGdkWWJZZVAvWGhscXpVNFBwNHJ2OTY0WFl6MWR5YkRJSjgvM1hLVlBO?=
 =?utf-8?B?WjRkZjhyRjN5b0lTaXo1VjBXbUhRcGJxb3lpUUFna2J4cVl3bVZ2MSsxcVo4?=
 =?utf-8?B?ZGcvV3dCQU1HYVhCeEx6Q1hKQkYvMG82cUpXbE90SVNxOVJ4d283RkpKeUQ3?=
 =?utf-8?B?OXVsV0JMNW8yNVVIc0RBT3oyNzVqMTdwaGErT1lnQmRsM09lZ09LWGo5QlJ1?=
 =?utf-8?B?REk5dHhTSWsydzkyd1NOSUl6V1pBTGJuNnc0RjlZSlVGaXNsUXh2QlJWTzYy?=
 =?utf-8?B?M1l2Vjg1c1ZzNDhsT1ROUVhSakFnS3FvV3dhODdQWlhxNTdXWHVnSklWU2V1?=
 =?utf-8?B?MU0zdmZmZVQrbHpDWTRCa3ZDcTlJZlB5RGF2N1kwanNKZEdBUTY2RnR5S3dq?=
 =?utf-8?B?dTExSGMyN0NIbm5QN2ZUR3kyQVF0N0E1Y0tkeS8wUXJHY3A0d2w1TDRqc3E4?=
 =?utf-8?B?V09EMDRNbjVSNytvVE1nQmVlek4zU2hPNERmQ1o4dVdmdjhRSmhJamZHa1BE?=
 =?utf-8?B?TlJIdjcxMzJ2d3l1TGFLRWc0d2xYdEZlNjU5S0R0YWFidVkyRGRSY3Y0MGg5?=
 =?utf-8?B?bUpzYXV1NnJPQmEwYzZuQk1EUzg5NzBOdFgzcmpWTHhYNjVMdGl1SFB2dURO?=
 =?utf-8?B?eVVHU0crTnRlRDZucUxmSnZoYk80aC94dDFDa0p1R2J1SWdhdEFFeC9MbkNz?=
 =?utf-8?B?QW9HLzJETFJFb0RQRlVmS0Y1eHdUTm9wZlhRbWNGNUhMSnUwblUrRzBSUlVT?=
 =?utf-8?B?VzVMd0JHNFkvK1JkakJma1MvWldPS0F2cS90UWNJZm1LamNkelBqdG83NWJI?=
 =?utf-8?B?OVB4K2lOeHpVbmFJZFltVlArb3FETitFOWFSNytjdkdxSUI1clIydG5ZMit3?=
 =?utf-8?B?bWJMSGJqakdiRk5NMzNIVTZUTTBFZ0tDQ090bFU1SytQSFd6QU1YaVZ4ZDJ5?=
 =?utf-8?B?SytDcnpnU2VzVGhpZ3FhMzRUWFVYdWowbjVSTnQ3S2xIQ1dQWm12bXVGekd1?=
 =?utf-8?B?OGtjY2hPbmhVUmJQYVpXR3BIRStWY3lxd3hsUjBucmpKZU9rRGVWWTBuRzl6?=
 =?utf-8?B?aUxQQmI5VXNMb243VXpMR2JxaUl6VkV6RVhVNXo0ZlAzUHV1eDZ0K1h6QWNZ?=
 =?utf-8?B?Vnp3eXZaZU5hdDZ0R0lMQkFZZjVDODRwVTkvN0Q5b21jMmlnNStwVjFGbExF?=
 =?utf-8?B?RWFid1dac21LQ2FaRnBRekY0MVQ4aUFoK2JjQ1Nxc25PT0x0N3BGYjZLRm1Z?=
 =?utf-8?B?MXNOZENhVi90YzUwZzF5MFlMUHZIazVXMkxBS0NwNFl3dEZaYUJ3UGFDNkx6?=
 =?utf-8?B?MkxpVm1zV3FBN1ZLNHN6d29Fd0Nrdkx2QVpqekNNbjdZSEJzRnZBQ2lSMEl3?=
 =?utf-8?B?WkJEUDkzb1VzeGxrOUlDSUdHSnloWWFXNUVFR3hWaWhRT1crTEczQVg1QThw?=
 =?utf-8?B?Z2JvVm1tU3RIZ2lzZXBrTGFwV1U3NWlYdDlRUlozOGhYcTczRjdnZ3pBUENt?=
 =?utf-8?B?OEE3VC84aU10clNXSnk2WlNaZncrOUIySVBUVG56Z3QyU3A4U21ZNFdVbC9F?=
 =?utf-8?B?NS9yRWs0UlZsZ0pIcEhsbmJkTkVUbWFBM2pLSUtSMXpxbWlPcHlDTFRGeE5B?=
 =?utf-8?B?TDh4WW1QTE8yb2NNakdYN1YzNklkVElYdnpvZWhXeTgySkNrY2xVMFRxNFNv?=
 =?utf-8?Q?0038=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3hNdzJxWVB5SFRNeFhleUlCRm1sZHVIaUpKQkpKMkdBbEFkQnROLzB2dit1?=
 =?utf-8?B?NzFiVmNpZmlBelUwVSswa0EyditSWnd5Q0YrOGtrY25zZHI2bjlESmt6MGNJ?=
 =?utf-8?B?Y0lpekdSYVAvb0krbnRhaEhOdTFtRVpWa25lSDRiM2JYOUNrZEZmNFdSSWcw?=
 =?utf-8?B?Mi8zUzNmNXhxL1phV0ovWmZ4aVNBaThDTlBBUm5KL2dSeWRRM2x4SXEyakNk?=
 =?utf-8?B?R0k0UHdHQnJIelBNUGRxUWZIanNUamtobE92RkFLRUpRQ0FIQkhtOGExbUJ6?=
 =?utf-8?B?VEpieUE4SXNHQnRMTXNsdlpWUmo4N1pyYkpFNmZSQjlEZGhEMUp4VVd1U3Nj?=
 =?utf-8?B?UjROM2ZVL3pnYnJJTXJUbmphMEp2SjBKdnFVN25VcXI4ODNxcUVDTDJWVzNP?=
 =?utf-8?B?TTVVcWdTNGdBSFY0R2VoU0ZGTHc5RUF2Wkh0UTU0TDlLRU9xS3NvcW00MlBz?=
 =?utf-8?B?QlkwS0F5N01NS1RBSmppUUY1d3B5ZzNTMHhDYXdFQ1lYV3NEeWdDa0k2Uy8z?=
 =?utf-8?B?U1NiZkxNZVptVUJhTjJpTXFPUENXS2YzRFR1L0dJMTJIcWVTaUhJLzZiK0Rs?=
 =?utf-8?B?bGNtdDFqUXlyZDJLMnRMUWtBbGk1Vmd6NEg1Qm1sZUNncGpjenFxOWdJWkIv?=
 =?utf-8?B?UUtnRUJMZExPbFZqQjVraUduMUt0MDY2Y3orTEFNVmpDTzF1aWlPYUtkYmMz?=
 =?utf-8?B?MnR5cDJnVzZLQ2hGN00yL2t5RFJFM2Y2OHAzRHRVV2FTemVLQWZwQzZGU2s5?=
 =?utf-8?B?Yyt6eE1VK25GVXlDN0k5TWQybWRacC9PNnRtc284eEdmRXVOZlowUGlyYkdl?=
 =?utf-8?B?RHM0ZUJjWW9oMGVrNWswRmtLenErR3A0ZG1ObkY3bzYzYy9Xd29IRm1QL3ZK?=
 =?utf-8?B?eE8rV1JDNm1sa0doaEVTZktlY2FmTUxtVGZRNXg4T05TQWhVZzdxVHdpR20z?=
 =?utf-8?B?d3hGQmZKSmluR2FjYUE1bnkwaUpLOFRWcURRQlNQQXB2MXZCK211SUJtUnJG?=
 =?utf-8?B?dThRV3czOGozUW1yU3UvNVNEVDlvTnNabUtUOHExQVRaUndrTWY5UFFkT25G?=
 =?utf-8?B?Uzk2YlFDdHNDUFNZUXA1aVRxNm1wc0J0a0ZDYlNuNmdJZFZxbFFickp6NnY3?=
 =?utf-8?B?dC9PaE96Z0dWejIvMlB1TjRyYnB0MUFNZnZvTzVRUVJwSEtqdDZTVE4xMkVn?=
 =?utf-8?B?UXJuUE8yMGo4QWZDUUtYMjhGNzNKTHgwTEpkUlpRN1VPeXFpKzFYVExKaUhH?=
 =?utf-8?B?dmFGMmlyOUpXeDdwbUtySEhKQ3kwYWtXalhucjlzNDBlcU1oVkdUYzhsWnRL?=
 =?utf-8?B?QjVHWmFwa1ZENWNXTzMwVjYvN0RNRmplT2JybXFVVTVSZitxRitMRE1tYmFi?=
 =?utf-8?B?ZE44YmVhSlYyMGd3MFFiNFIraGprSTNEbDY0K2dUY3FIQlFCMUpwOFNEeXBm?=
 =?utf-8?B?clJyMGpGK3hyY2t5SDhSNmJDa3h3MytsRUZueDQ0V1B5MW9lMmRQR2VsUXRM?=
 =?utf-8?B?TGNPblh4TTh3MVhEU0pLMTFDbGR6SjlQYlpza2RlWS9WeEREKzRVcmZpOVlY?=
 =?utf-8?B?bVpMaVZkMEtXck1EdnFRbW1kVUVqNWFEeEd4ZFBoNEw0RmFBVGxuem5UdFlR?=
 =?utf-8?B?Nk1nMmlSelZxeENhcDVxYWFrYkw5bjRHWUVJUFpmZnJ6bTJwUFBzTFQ0S3lt?=
 =?utf-8?B?QWVYOXdpb05JSWJPVG8zR3FjSlIwc0kzR0dGbllVb0ZDV2M3eXFMYjJycW83?=
 =?utf-8?B?WXlRZGI0ZnNvRCtmSVpTRVNnck1MYlNhWXVROVFSY3AwbHZ5N3Z0L0NrR2Mv?=
 =?utf-8?B?VUtESEtJNEQxL3A2S1hES2pvRG13ZjJWd0cwNDlOd0JCY0t0elFTTWh0RXcr?=
 =?utf-8?B?UjJsU3QvdjZuN2V2eGJ0QzR0VHZNN1V4Q2NGczgyODZzczBNNHFBT3JYNnp5?=
 =?utf-8?B?ay91dWlCVHVLTUVxTysvTWFVQVFrZ1RhSHJxUTBqRVlHbmZ1cGtmWEhZTlZq?=
 =?utf-8?B?eG1pU1NsTjRsR1BhU2xBNE1DYm5hTWphT21yQUhPamtQWjVWUzAySmtRczZh?=
 =?utf-8?B?eXBiRUZiWGExSHd1NEN2UDVQODhrenF0YzdjT2VlRmpicnMyd0plT3JqMjZw?=
 =?utf-8?B?dGlRT2pPZ0tuNFBuLzVDMmJGb0M5MjJiNzA1cEkvUFZlOTBBTjNiemQ3azA2?=
 =?utf-8?B?aExYeUJlZ0UyVnFoTlBYWFFzZHhrZkFsVDZ6UTBNMUkxWE9UVnVCV0RzcTJp?=
 =?utf-8?B?OWhWY0JTNlRSYWtjRUJWTElGdG1lODZ2YkpmVlJ3ek5hZ3NTUi9XdXNra3l5?=
 =?utf-8?B?M3M5Y1J0MmlkUHFBRnNyVnFEN0Z6RE5RMlBwOFpGMEpPOU8xdU95Mjd1VHJk?=
 =?utf-8?Q?0iuhg0mFxTMTwKeQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etZV+e2taf7FyPGztWh5PzSKc2/wn9niyeqZ1C8VMG9nNA0kJ9KBBDNYcmDkMjmhHI6N0N7cqmZiVmHRZNflh+qcsIAQ5i0rciPxtk5r+bwahD1azEdKsFomsWyT7g5MpyIlI0paX2F+yUJvsaeQQMC1QFlWQ5+Wb1Xns1+1m/lnyR7OaTfnYizcKBaWBqIgBIMRPwH24ZS9LwdTAaU01vitsZ9qbeNRSVcoM9MacvpAvOLtUrdzksRoCtrwm8pOZlZnkGgYI0qGf1k2D3n4hUWxe5GCuROHrOMPrG0H43Dfm8xYrkbJ4+djbQFzorFsWsTofJ6Qr7jlszpnDox5TMV1EzLsFIwqTTO2+lDygAyio25LLhZp2texgQrRCjpdDSNIwh1fzVstyeVwvzduyFY5lsi7ns0rrdH/WPjh16+4VdjVJOxyYA/6bTxYfPeuE/ywGkP76Uzzy9WmTYloVeJdoYMw3pAk8YgG+5RngbJDKO1Hx+ErkdDhu0q5ZViWwnxgLNsB1W8L6/83DA1JZnrO7PD21oYhK8tkkByCyCuxfvQXNQgVTULZx0aSjlDzzF3iv4lM0nbIaKnGi0fJyDVgoK0ft63OepJ9n0DaHwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b179b5-dc3f-4140-48d8-08de5e63237b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:48:22.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Uav7X/EXMviOC2MG/msZmhyjl0ZtRsMnvjRuCC+yVALC9QGyBf4ShhEmYMJnwCocYmZlcO5wYWqyzASgsL0aaWCvHpP360dy2TQFS2QKHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NiBTYWx0ZWRfX+vH1MXwmIOJe
 B6xWfeNGPwzEIr3z5BMZhSM8fbsimFxoNl0PYzgyRu81cU6bWvtyfnxB5gqBjk7bIGulN6UCGYA
 n6rZUpJPac2kCGEomhwTiBholcI87Ej2UF/goDSRqyk26ItCC3HpabNA820/Q1hIxrm/Ws1T5CG
 IwgDPuzmGhC23yjcFkgh+FNWjPC7bkkZ48G6WdSyqbKeROfimvj7FGkxqn41oVc8Ufdjd6ifov/
 iDeArq50MXXGIoyhK3Hzy+GZ+KsD0Mo4vkKYCSN/a6xRcKo9xf5M5OvegwNpAiUgPj04WR+jhqH
 NiYx4okywaaSdX+D8zIcEHKzn09MF7B4lc/ttSYnnQE6bH8Wh2hbrMf5uFAuJxqlxSoiMhz+viQ
 SiooV9Rk1a5bcHlfrvEuQ2lrH2NzD07J9EwfBNPGHgGJvnuwku3PYomKl9QV+kocGOFe92fPpcy
 4PONWWPwgvcTktsUP2cvMvq/M8ebOQ2CrQx9mi+k=
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=6979f78d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6XYQmp1qTaV7KrIGAtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: NdQi1pihkxBsaPhFn4SKSUdtKStiMQex
X-Proofpoint-ORIG-GUID: NdQi1pihkxBsaPhFn4SKSUdtKStiMQex

On Wed, Jan 28, 2026 at 12:37:49PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-23 20:12:14 [+0000], Lorenzo Stoakes wrote:
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -78,6 +78,37 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
> …
> > +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> > +#define __vma_lockdep_stat_mark_acquired(vma) \
> > +	lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> > +
>
> After going through the remaining series, I don't think I found a
> matching lock_contended(). So perf/ tracing just give you a few
> lock-acquired events. Wouldn't it make sense to also some
> lock_contended() events where the caller had to wait before it could
> acquire the lock?

Yeah I did wonder about this actually. The series really just abstracts this
part, so I think doing something with that should be a follow-up.

Suren - what was your intent with this? I did wonder what we actually really
accomplished with this.

VMA locks are always try-locks.

Write locks can't be contended against one another since VMAs are always a
per-process entity and not obtained remotely, so either a VMA is write-locked by
us or not write-locked, never write-locked by anybody else.

Read locks immediately give up if the VMA is write locked.

Would we want to record a lock_contended() event in that case I guess then?

I don't think we'd want to do that if the VMA were detached, only if it were
write-locked?

>
> Sebastian

Cheers, Lorenzo
