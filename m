Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01D3EBF2A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193935; cv=fail; b=S9oJDg8nAz87fsiwJ5ex5b/0JBq0zYJNPJ8dY1Txf6FJib1hkARBx64nQi3ehkk5XIroCwH9CY0ngqs52wzzrT774Cvh7W0I+vn0jog1Y7QT3CMX5WS4SMofXXLNQ/wfBrNM1xHOxZeBU4PZLtHERzV0QLuNrTN+jOuN6WIMP5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193935; c=relaxed/simple;
	bh=NOdr69QkTFSxoR4GDDrIlaUk4QS/Mol/1You0zVjsvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cBLjTwlMP7VOaljRIpn3HljRQCxjyx9wBo+lrCj17mm+FuUTgMK0TwUoEEJGo7DIdW1DZ3MWRXCs7umw1uXlvUzuku/ikdX1TyuEB+fOOchBPJHXFwoA8y6zUxPOw9CXwyF6QpbFN+zLtyUCtzu2ohLzpXzAUq97po3MbEB3zVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=djnLsu0l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S/BC+aNA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djnLsu0l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S/BC+aNA"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NE8VOf2029506;
	Fri, 23 Jan 2026 18:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NOdr69QkTFSxoR4GDDrIlaUk4QS/Mol/1You0zVjsvE=; b=
	djnLsu0lDnBPPA9DqgMWdMQKtaEy1DzGcSdMi8+D0uxOBHyKXg8OQCUmqw8yGYhm
	aO1sayLs7BDTws73oZ9Th6uq926hwCULdwZEOlrJFkDybr2tX9iu8904tMAqOTpr
	W90ivCJhcn6mX6xu9velqjh9Y40USJ1fWwgQaoCaMpvxjV0A1cfDut5SZXRB6G10
	sC/mLif1Q7M4QnK0mX3GTJoyMyrW7WOMqI6iN/m8rzPEPFYkhPnemWddgxsE9QDO
	lUTOGngM+4l3555ATeKHIIGbHQgNxPlD17+cdw4EOUTSjVKAQcWawU2wNvu3513z
	F5Xj6XDZMR2TEGWy/FjP/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5tu0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:45:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NIOJY6022453;
	Fri, 23 Jan 2026 18:45:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vjgtjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlStzTB42laltWv2jnAtpibK64h3gLpnkU2zKjdHFnZ0e0gw/EOJjfwjMMOCBJrqWNpgzVe36/HKWe81xQHqTahnag7jbDykUvmT/2fxZ14XKUg5CnKMiutA5Z5Rppyj8fxGNdTF/yftejI8GNwfGjDaatxRmXyvpH8tjhmImQ5K0r6eRP3FOzc0V2MTXtL4R2iT2U7WUdKnF6jC77TMNCtg8v280w6msx6NO81aCQTd+tt1+sfWMjYIvcvecRTFWnWartzbUAAhzM93zC+YLNML8xB+qot3acM/9NZI9fKA2BdTykb3S1YScsBE8TSKqcV+Fy23vSifXgEL2OCkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOdr69QkTFSxoR4GDDrIlaUk4QS/Mol/1You0zVjsvE=;
 b=HrvsUyvuWYDFa9oxo9nUXZmi5ktexuGoc56HSmTPhEYvvzXPO8j3TrTV51ct+N4XEXLqdiHNwh4tIMnhfwmz9GPgoRjtuUsbSpVJjL+bzJ02b6YrCb6CGI0E81RTXS2mOPG+RFsD1gp93BiaTFQGOFUF7icRKPtmTC+Hir9P0FkpS3yv7nj0zGmcWGmdVV85OoeCc5Mr+FWqtaEoNhOwrvNplHQ/r3R056NpdL4PwgyPGyUCm1vYofl76iaSfXYRtNRlJZcy/FriWUvW5+DcwI44TC/sbWJWBLB2zVv87yf7jtw00Pz3n4fMfRC6x6RJJR7E2fbZNHj6hIcOPzDPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOdr69QkTFSxoR4GDDrIlaUk4QS/Mol/1You0zVjsvE=;
 b=S/BC+aNAYluH1X0kPpb6vIrhXvcYbPIigG5tW564wEQn1njfoy4KHRJgSgVky5569e5baXYHoIyOkcRBcv2WOGkhaQKXxgWPXGEtyMGimfgBQ2fQ1IpM+pFKJ360TCuAqwzHNmyJn0WBHt+FO2ie5Nb8OIDaRGh1kTlZrhoG4u0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 18:45:10 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 18:45:10 +0000
Date: Fri, 23 Jan 2026 18:45:13 +0000
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
Subject: Re: [PATCH RESEND v3 09/10] mm/vma: update vma_assert_locked() to
 use lockdep
Message-ID: <2266bb1f-8e22-41c9-82ce-fc46fce48ffb@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <fbaa0ab025c1f345e559df2b1045b223663806ef.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpG_5Do+Qajtnhbv9uK+BssDh7NpXYGzfbKBJGZgtiKF0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG_5Do+Qajtnhbv9uK+BssDh7NpXYGzfbKBJGZgtiKF0A@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dd2647-0747-4939-8991-08de5aaf893d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFQwZ1FCSTd5eXQ0SzdPRFB5Zy8wU2VTWXB5cFpsOFcyS1V1SGVyanpIelhE?=
 =?utf-8?B?Tkd0M3F0YUpiYTBTa3U3eTdvaEF1Vm56cWVjQnhISjJ6K2RnKzZXaGFoTDlv?=
 =?utf-8?B?a0lFS2V5UXBqY2ExUFdJaFcydDcwWXM1MUh2UTV5RXg0VGhZMkN2Z25UcGQ2?=
 =?utf-8?B?d3NEam5ZQ2JKeklIMkEwWDIxc1ljblB3elEvUzA3Uno4RnNtV2RkWVJOUXlT?=
 =?utf-8?B?RFY4cHdkY2FHcytHODI0bzVYbERBVTRYS0tCdUQ1ZmlkbGVldmx3b0VHY01v?=
 =?utf-8?B?SVhZeTBaa2RHdVc2MVdkcGQ0WGJxUHFQZW1Qc2FhQU9VUFlta1BST1BLN09s?=
 =?utf-8?B?YlZ6QmM1cS9tNUtTeWdXVzVTNWRXZ2VsckVmV2pIQ2o3ZzQzYSt0cVp4MFY4?=
 =?utf-8?B?NHJXUmhKdDBNUzZzTU5XbC85d0VKYUc2azA3bk5QT0VvZ0hHSllVbmJoVU5l?=
 =?utf-8?B?b0xyNDkvcE0vRFBKL1lPb1hSSFFZMFBQeHY3dVd0WjRhMVFkWjBxVWFEcHZK?=
 =?utf-8?B?eFV6bzBaTTJPd1Vrak4vaWo5eklaaWtXV0RHZ2p1MDliVUsyUnZWdU9jeVlm?=
 =?utf-8?B?dHZydjhHcGdRcFRNTU9tSFMweSt3WE1tSFFBdjNWelEydW9jZjB2cm5IRWxS?=
 =?utf-8?B?THJ4NVpHZis0YURadlFDNCtRcS9CaGdnWDF3cWFnVGdkUXk1TU00T0diT2dw?=
 =?utf-8?B?YzJZUzl6VnZ2SlpJcjVEOTREMVlHb0lOMlFMSHJ1Q01rQU54aWpVa2VRK3F1?=
 =?utf-8?B?WXNTVkl6QjhvN2ZXV0NLQkk0M0hQVFE4SkxkRlFBcVk0dFVoRkVGbC9TRG02?=
 =?utf-8?B?NnhET25SOTlPWUhoUFB3S2Y2L2lsZUNITldVNkZhVFQyNEJ0blFyUENQK21J?=
 =?utf-8?B?Z3ZGVUNUUm1vdm8wTDNDYTRPc0Nwc1lTbnZ0Sno0Y3pPOWFrSHpvbmNVdnNW?=
 =?utf-8?B?WHloSmdEZjZiYlZJdE81cWNKNDZscmlFQk9Zb0s5ckIxMDVvZWZVOWhLaGVy?=
 =?utf-8?B?enJQelozbXJOY1lBZXBmejJrVThHSzRaV1JCRGhwUXdnd2VOci9sUlNhRWQz?=
 =?utf-8?B?MWZrVlUrSFEvM0FhVGVBcld3RGw4a0k4aS9DR1pqa1NMVEVwQi9SWEV1anVU?=
 =?utf-8?B?YlU5a0Q3Qk5ha3dvVDFKSTR2bE1oY1ppQzExUTU3bHBoVEZHeFJieHdaU2Rq?=
 =?utf-8?B?bGNiTU5adGJpb1l5MDhrRWlnSnRRcVluVHBrczh1RW5maVhKTFdZcXF0RE80?=
 =?utf-8?B?OS9CeHIvcldoUm03RGI2R2NIMVBrbU1nTFNvNnNlRTlrZllQRjRzN0E0QVRt?=
 =?utf-8?B?bktzTjh4bm9KNllMOUZTV0YrYmdxejd5a0tPdnZaRktRc0lqOWNjelQreCtq?=
 =?utf-8?B?dWxGVmlzaXRYNzRaNm5Bb2lxbit6YlJTczlKQWNMSzIzTXYrZkRuUFpObHJJ?=
 =?utf-8?B?V0FQQ1dpV0hBNU9vbjRGMFhPSVNxRUpHdW5PNEVLWDV4Q0VIM2FFWk51SWhl?=
 =?utf-8?B?NW04WnQ2NnlMcm9xeVRyZzc2T2lCVmhxdkVsMjBzT3FoaitUeGVRdGhvVWw3?=
 =?utf-8?B?T1NJWDBSTno3ZlFlTmV1dnUvOTlUQkZ2akZ6Z2JrTlBPbmhleHNWcGQwMlc1?=
 =?utf-8?B?cXpRTk50c0Z2MllxVVVDcDg3Z0p2NzNOdEFKUVg4a3RlUWJURnJ4R1JUWnhP?=
 =?utf-8?B?UWhvUWtST2szWWROSXFyQjZBSGRCaGZua2w3WURneCtMRjMya2ZrbmVUS2hV?=
 =?utf-8?B?ejB1YzYrRHcrb2FlMzUyU2NuV1dQdEJ6UXU2QzJMOExBNFBpOEdQSFN6SzY2?=
 =?utf-8?B?MTFYTC91alAvYWFPV2d2NGQrSXJZWkE2MGJZY25QY0VWcjdJMXN4bVFjVmRJ?=
 =?utf-8?B?NEFIRHVxajNNM25OcGcvVkhOcXBOc1AzMjZORXhLRCtXMC9MWDQyakd4SjM0?=
 =?utf-8?B?UnllYm9ZdVlhcjl4L3llcjJjR0lEbDVGaTFSbVA3Y3NkU3R3UUE1Z0NSK202?=
 =?utf-8?B?aFV5dFJsWWNTY3hYcVRCUzVVaUVPdEpMaGR1S1ZZZERBSkNZLzdUcEZ2T1lR?=
 =?utf-8?B?VnM3T1RJa25yVDR4NHc0SGwzcDZ4Wmsvc00yK0hPZitJVjRLbTB3QXBxeHhk?=
 =?utf-8?Q?IpPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDNLeE5WVFd1MVEwdUlzWk9kbHBRbSt5N2UvU1dWR3BmMDh2OWJUME1jNUZh?=
 =?utf-8?B?RzgrUzlOKy9CUXIzQWZRRFpyTlVoVkd3YnVKbjFDTGxqODNtblNkOEd4bXdY?=
 =?utf-8?B?YVVxaHRLUDZEdnlzNFZXd1U1bjdNMlNTN3VVYnhqMnh0d0VIbnpQYjVsZVJU?=
 =?utf-8?B?eEtnWWpLTDBiOHRlL2ozNzI2N0NLVG9TdktWdngyZmY0dThpMmpwV2ZIa28r?=
 =?utf-8?B?WVFpSXhZQnQ3bWFYNkd4LzBzQXpxOE5DdUlxSUhkaG13MUx3bHVnWW4yS1FN?=
 =?utf-8?B?SldYMStLb3E3K09abkIyWUdCTXlCcERJcUQvNkJGZjF0TVZia2R5RElNeVF6?=
 =?utf-8?B?c1RCYllMWUo2U05kc1I1Z0lGcHpZczZoWXF2YWNJbmUrWjZMUlEzNWd1UFBi?=
 =?utf-8?B?aVN1Y0RSWlN6SW5MbXRIQ0FBVHlIUlE0aFpKWEdVMnlZc3JVcFV2ZHk5Zmha?=
 =?utf-8?B?OXBqaVlzRitBUm9JZGNDNDhrZUJIL1NhZk56QjV1SU51OUw1OGZTVGpEU05R?=
 =?utf-8?B?b24xTWFVNkFqRDYrTVRpbGpQajE2RzkxRVQzQWFQckhadkQwYkJObVJpOFlw?=
 =?utf-8?B?K0RGTVBBRVFoU01IbE1wTnNsRGJkVUxhODZpWENSNVZyRmR1ZVg4UDRxOWFr?=
 =?utf-8?B?ZFZEdk8yN1FMUzgwZmF2c3BPdk9neElCMENFZVdNY2ZHSVR3WDhVYzRhazU0?=
 =?utf-8?B?QzlXNk5vdGR4L3h1cnJFWERCMFZibUl5Unk5UFdTYnNLMHd2QmgxdDNlMTZk?=
 =?utf-8?B?MlVDNUt3RmZnc3htZ0dTOTRDcktaM0lDTC9QZ3N4c1M2aXNiR2YvNWVNU2JC?=
 =?utf-8?B?Uk1RV0k0TTJNS3MxR2VvRHRCMTE5bUtENHM0V1lvZmxFNmo5U2lrQWNYNnNw?=
 =?utf-8?B?VUp5VmdsWVNuREFESVkwUitVaEgwUldiQXMrSitHNjYrZG9VMnVYUnNnUkRL?=
 =?utf-8?B?aWZqRkZNeG1wQXpiYmJBVFVUelBIQUUxYnpoZGJEU0EvZ2pmUTV5RmlZNTh6?=
 =?utf-8?B?NE43dHdPOStWbGc5UGcxU2daa00zZjdTZXZZSWwwZER2UGpkZ3VOZzROVUJ4?=
 =?utf-8?B?MzdFelJvSHBmaG04dDBHclU5NGE0bTJocm9IUzZrWVlpcFBuVjV1RmtYVWtE?=
 =?utf-8?B?a0NhT1Y4Q0tOdktoZThRS0VuTWs4WGhobS9HbHVHdE5tRUZBcVh5RHZyNFRC?=
 =?utf-8?B?bkR0K0Z6QnFjaktQajVod2hxRFQvdWE4Yld2ZVVKQis5ZkEzMTJ3T29tTnVD?=
 =?utf-8?B?S1ZWM2Z2UmVpRDdvbDJiYUdnOWVvMm0yQ25tNnV1bWx5Y3UxcHpHYTFEc1A5?=
 =?utf-8?B?YlFKZ08wTDFqeVhtZENlRDV1Q2NCbzV1S29valZLS3JaZTdhZzJYVGdRVWZR?=
 =?utf-8?B?ay8yL3VVZnhoalRDbWkvY3VqSll0aU9oSThWN2lja1hwVnlnNGhzbFJGU2Zu?=
 =?utf-8?B?Qmg1WjV0ZWhTc0Q1TUJSbzdjMVVzeHlpOGFwZmJNNTBWNDVJNkkvc2llMnlq?=
 =?utf-8?B?ckI1dUJqTGljUEtSaWJOVjB0NVk2R3lDK05VVU9mcTFaNThYY0Z4STZteVZT?=
 =?utf-8?B?dE5MZWcwdU5xT1lic3hKKzBJdTVOcWlYR3RvaDdXaVdBcGNUcHY5cDQzWTMw?=
 =?utf-8?B?dkpIUldQQTZOYXcwaDdySWpWT212Sk52NWowWktMa0tPMHVTTzg2TVM3ZmZz?=
 =?utf-8?B?RlZleGRWN3FVQ0lNZzg4UkE0RzRnZG1QMllOWGZKT21IMUh4L01jYkxrRmJC?=
 =?utf-8?B?a01palFtUFh0VGthZ3JGdHRjTzQ4SjY2dGFJdnFaeWNUalZIRmJCZWlkWEZW?=
 =?utf-8?B?K1lKOWt4Si93d1hxaUhXM1p4cFhReDZEeWNNZW9wRVNySC9UeU9QYm5NZWJz?=
 =?utf-8?B?TXM3eXNERVVTQXJSN0dzVXdXUzU0c0VKU09TYTlZeTVSY1puK2dVSWhiazk3?=
 =?utf-8?B?T2FCRlpSWUlNR1lpR29PVXVmK3JoM2hpVmY2OFY1RjFZL0V1NVVTL0JNRml0?=
 =?utf-8?B?T0FaZ0dDNGtUb05aaVFpMGFTRHExWUtScXFuaWw0U25xNzRYVjR3NGVSUW5u?=
 =?utf-8?B?NEdHV0JydmdTV3ZoMGdtYzN0L1FUU25zS25EbHJRK3pVQWhiK0orczM5aXFO?=
 =?utf-8?B?Yk0vc3JQbEQ2YnJwRHRSVTJtWHdpdmZZYnkwU1FWTDhVbUlRRFRPeU8vblJB?=
 =?utf-8?B?aFpWTDFWSlB0dG9ncDZ3QWxjS1F5eTU5TDVMWm0weXUxamRWaWowNnQ5YXpI?=
 =?utf-8?B?UlNPODYzSlNNRU5BN3ZmVUdZeHZoNXVvWStwL0tGcDQvamNoZHZMOXFKQzBp?=
 =?utf-8?B?dkxUQThUeVh0YlkreTQ4TXV3bk45dGJOT1ArZjhTQkp0anNDWnkyOGoyalRL?=
 =?utf-8?Q?NaQib2OY25FiQqRk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fny9Xiln0e72en3ScPDrTb0qBdCdPfDJtl0TM9QKz8j9OhslMorBafP7VebyL/7WzgTElGjs1Xd9BQYbx/eSqinFCprf30+ik2dWL2d1HJZyGzqc84cjyyZ87D8kKsd/Iw9uS2MUFCjAbZraHGMnPeAhoq22tKum1F0TnDb4JZMyxV14cU/c9yD82YfVcTrB/TGYUALP0A3H2eZfGp3iGOcevcyBG5zyO/ZnY9OJ0zJG1A0oIs5NKnlYL9JyBAYkqyFgqCPyzqKiXGGyDrdP8rzF9mE9p314OkD/70Ckc1mAszqbmc71zaJyGhRYO2japvBg6JKJQHW9/ekBHFSn8Ig7Y79BQvWBUlCXCXh9W/tk8yndTvCY+wLpQmpUtcz189yTYEfKBNHtkYAtGQXsJ39J4r29vRFmU3HhxcUt3osiQN/Baet008WDCd48gjNqNIHe1EdxXwgFuGJjxt1HO2lh3C+pHcuxbcT8NkhSemIgTYCEKzGGarTfEoS4m9EXDBYewtPei7vKUhPQ+UlBewAeFrmUbZxy+dllIrLmvwvaxp/Iyx8Ljt16RbVv68MmJz4H7rY+JFu4WIVMTTZDcI1XUdpU+nReT+niVVv83aM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dd2647-0747-4939-8991-08de5aaf893d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 18:45:10.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F6+I9zebtNS0i1NcdVCwYnb8FhWxyjv7L7Iap8Sw7AMOQvrK1+bO0llUXu5WnRFFND82NQy4JEiF1zWSUXXYGPigBhHduwyzsoa4vTQoh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MiBTYWx0ZWRfXxHFEA+8v968s
 iJvleSf4eS/d4f/PjQsUBHaWODL0EGJz8sYMkGGunfTdbetBF8KNAi2KqrKrCnhO2NYPTmorDvV
 bXP1Rhh2eIqCJk6Uw8Ra68r0MrSZ3rxB552F2hYVId7Lp5M6IPc0xiOxEvOSDpczdHEmMtvMQJf
 0yG9cKL+b4oFmGjZPcrb4STAFAbq/TfwPrICsZLyniYUIftRSq8jzNuGetisvuY3zbdmQSevQu2
 VAPXSdw/QbAch2lqs5amhK1HJ1wiGOVfIAOCcR/aYYELu8yICJdRT740tUv0MMSOdnDAV6on7fd
 YLEaTEZJrC4OMFSMdS8LoVNWAWN3cPFDvHtAGhikrXLsUwNQrCJ6502QGJqzcHXuR13HAVD17Dn
 Ecs4tu2sNKzAlUPpXM1yiaxTYEtvadp0Ly1KOh0vlqepW0DJAF51QKlg8HyXApPmqZ/fEvQ2xCZ
 bi5ZDBOAbVIRidkiyYbXd2VlUGc45XMYLyQic3k0=
X-Proofpoint-GUID: sCmq80Hc4tccz0v5pMIFZgVA9sM4PAk1
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=6973c1bb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=Lf7Uj0OYqROCGcuX-nwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: sCmq80Hc4tccz0v5pMIFZgVA9sM4PAk1

On Thu, Jan 22, 2026 at 02:02:53PM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 22, 2026 at 5:02 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > We can use lockdep to avoid unnecessary work here, otherwise update the
> > code to logically evaluate all pertinent cases and share code with
> > vma_assert_write_locked().
> >
> > Make it clear here that we treat the VMA being detached at this point as a
> > bug, this was only implicit before.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Looks correct.
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!
