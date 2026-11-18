Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795008711;
	b=vb533Y4zYIsPkpSy5GGJeJMqiUPVg+whuapRGc1XDj5QL93ALWoj2eHVcI3U9hK0oTAB
	 bH5blwn7JfHT1lBrvIfzEO+HEWZialDrbKUENf3whwEOdZDK7Od3VCIMB5/oYCEPvkw5J
	 htDVh7eAFLFukNsw2P1lB3XxuXrrXWGiWXBJ4WNdoLE3gO1bbEqn1htSE1mYhNtKScMJq
	 bqcN7WseTauqseGoIEQ44EH3qtucMgVK90FbK3uTbT5Epwfmji5w+KTYr7v0Blq2w18PR
	 DqkWDH3xNaKo/6KjRBeW0jpRIhqmCXkzFprNYIvBLcYuyeKcCK3B7olwJpr8AzuSyZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008711;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FkOSgDsC+mMHs+oRP8pRdgJmfoewwD8yrGR/X5SJH6A=;
	b=DqVTx+Z7KVkqsVP9PVvZ8c/dsEf0vycBzyJH0SRD8PO7cpZun5woEteEAS7qDy4/R6Je
	 nxkXIbHrDfmzZ8xYPd35I7IamF+I5ks15hLmlcGbJcaD55xbE1KT/5saC8t0yhVYqmmQT
	 TRPFKwijw0od+eJW5fCFTWtX2j8fvDJC4Q7MfolZAsCkVSzLkvzAGJC6y9anpPDfgdB+5
	 8EuoFoLlVtp1yMbqVNydqoFMbMXz3h/KtRMCsNrQZAycXtnxSWXVZ2DSuzYyt8sIr3l3K
	 C1iGvNFJ3dw3sM/5pGrXJQQfqHHRGp8fj2LtW6DCiK+J+JuuMeNVz3ha+LrO+kFZJvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PM4t528P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.101
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020101.outbound.protection.outlook.com [52.101.189.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8D606A325;
	Wed, 18 Nov 2026 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC8D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PM4t528P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6fj3wzj2sS4uX5dpj6/MkDYpCQQbjJYxCC3f9edt72cpcvW/AccPxplkaOBKlADwzHx85sYD6HhnbiQxf2K6AfSe4pKkunOVeCgGt4RckoObhF7lDzrZro+AXUs58QHZiP3G9fZ4MeNuhI5EQLSijyvJRtZ08RtzXODaPw/caDwBjX7CCEKZR0tV0f/9pBvSyzMGbVQkKsfSBBRSG9ggtmCjN25clhtHCHQS5ZhUrX6zonSC8mpzEO5kYvo9/xjKtUsKrwS0/KIBDElEwwBfayo8EeIiAP4TSvvIDQlW6ZjFXGa/W1/l/g8PfW2H+4RfRZH+k5h0DIgfDzPQOPfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkOSgDsC+mMHs+oRP8pRdgJmfoewwD8yrGR/X5SJH6A=;
 b=tWbuHiV8BPSUCqaXz0pEvVecYb2FlvZZiOeiWiN6ekkCh1/sOj8TEjl1POIF99LDhOgPp2TPSQZn/WSAL0l9SOScODMEuqpH5VrTz0PQEHUSvZ7rsLMlFg17wPeuhLS5mLydrR2TaUb6Cyw9COvuV7ucIuBHL30NDzVhcFA4xlwjn4M8PELHHTq7VwuLdoHHfTSS+TLeBtDT9pII0oAmZFrE7ceOe3c2pv5h/qaou22G8goKWKmU3tlMkDdyAMr7xnLFct7wphp2+2Xb3EI1fU3Q9zcv4iUXye/fbSmU+a0Pwatjl+Q/X2nTUiVl/lvR19MPWn6rjLUSSQAi1iSnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkOSgDsC+mMHs+oRP8pRdgJmfoewwD8yrGR/X5SJH6A=;
 b=PM4t528P7pG6W2RFD2eU9+KwYLWbzOQtKvKSmszUS5JQYnPPwGcTKFEipH0juiq9gUOQhZbmlpr2Jd1I1KpxN231zNEc78DobsHEGgEz+h2993Ig8GCcRteEUtsH4JsuP65iyA/jDCHL18Dd3W122gvQm2OxalxwvfKD/CkAp7/k6jaXwCjCGVt9MwTG04zOzOVzz3Sfv6V5U2njQG9Zb1f48x21kwOvwpr4myq1ycIg3upkxyzPTCbUvO4bEMfNZiyQWAsoUvshh1UUNSi3u74uM/Qs2uW4GKfXsVeNHKuPyuxOutCNveeCjhEMhsFYN4O2/8mCHWUmQQJRDIHOKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB11645.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:154::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:31:47 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:31:46 +0000
Message-ID: <d5bbdb4a-1695-4585-87a3-7f561d4d614d@efficios.com>
Date: Wed, 18 Nov 2026 08:31:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/40] sched/deadline: Refuse dl_server debugfs writes
 while the rq is offline
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-218977@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-218977@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB11645:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f33c64-63f6-42e4-1be3-08df45784b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|5023799004|261022075727099003|4143699003|56012099006|10067099003|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QdzH7wI2L+KdHMbRCvXqLehBhaPAHjsNciYCKmsaVfp35CjQBnIsf9br/rUOIfeaVWbGTt2fUxviE8BeopXQXSGyzgzMiOIFTTPqfdMNJ0zUBiaqOjhyYS3+VSYRPqQawkxnplLE4wAQDQlDFsAOwERKpNxgFrMEglBWCbh+tgDXn52McuyOnIgC4j6LIb8J+l+MGk9puRmHopXJ5AdHWg1einhdkUqUNRfls46IKgqKGCDuX/59jOmUFsub8lzotcbcQh3WaoIW9PSxiatzbDss3jUCb8FvDr8c9bA6LYSFqdl5Pd5BYEmcUJNOeJ/Mi/TLZV3BbcgNDAJVaHewZEyJpoW089xpInkhQrir+HGnfGQ5rKCB9kwrQz7NsJdErQ2HMlNttdkwDw/H9QejAjBaVkQp2Koe+Ea/fDnXiCWjIPcMsyZrd0W6qa2NwBL+lQ7YKlJJ95DFu0Wz/D9Aw9/+UNNEYpQzyUInZ8h2eGeRuTXWrsksOKAze2p266OFSsilBULsgrhi2b0bU56JLuRmoQCt8yyv8kNCiq+4T0NFhTCXtxuPsx6xNL/Smpmo9vGS5yfNaZJqFKGLkZ4nVqOqqAhVe3lBqj0Mf5CXwlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(261022075727099003)(4143699003)(56012099006)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFPVnp3aU9icmJXWHl3QUQ3YWlsZTk1U3hoWGpxUzR6Z2RtYXRWWCt5YmRv?=
 =?utf-8?B?bURnZDJWUktnSkRhcHVCNlUyV3lKaEJYNTFkbGovRUxpQWUzUkZVNDBGcldJ?=
 =?utf-8?B?QXVsa1FUVks2QU5qdE1CbGJKQ0FQem1FdnMvOHloOE9oKzl6U1E0K3RSVStK?=
 =?utf-8?B?ckxibWo0dHYvMW9FVkJwR1d6WSsxRk03STlQWkJCNlcxM3JyeTlrSDN3VTkr?=
 =?utf-8?B?SDJqTUZRRDh0OEt6OFMwNytuTTA0SW1jNU1mQ0lIRlhYZDNoQWhiTXJEdTdR?=
 =?utf-8?B?MUQ0ZGVCWGkyOGc3YkIwQWVuSnFpQ1ZiSW9GcS9PaTBGdDBCL3p6SVZCenpL?=
 =?utf-8?B?WnFvSFVvZktrZTloTW1GR09Va0Q4a29LdFJwZENLS2NFa3RBeFE1Z0ljcVhD?=
 =?utf-8?B?Q1ovZ2ppakdnVy9TQkd4WU5iMnVKSUFoQVFRdkNGU0hqN3pzNzZVZ1B3UHVV?=
 =?utf-8?B?VzY3eEFTTFJnUGhEVU1FcGdrNGJjWGJId2hEYjlGRGpXTy9qU3FvVllBTHJm?=
 =?utf-8?B?Zm9yTHc5b2NaWXpNcGVyODVqKzJVL0MrZFRLMUNTclAwaExnWU9pUTVNbVZM?=
 =?utf-8?B?ajNSeVg4L3lwVHhDVVBrYng3Yko1cTVoRlVlMmRHNWN3NDQvQVZRbVZSMDI3?=
 =?utf-8?B?bGZqcEZFdkRvZDcrVE1uWlBDZ04reDZlVGY4UUYyYlZESkpGRitLWEJRdzZR?=
 =?utf-8?B?RVdMeVRjOHUzSWQwMUlrMy9XK2ZnbDRjcWVYSXQwd2wzUlFaTEM4UEFMTW5X?=
 =?utf-8?B?b0NiTTBudHFRYUxObjkrMndpcW5BOFkyQVNya2VZRDlqWVI2VFVYRllBVmQ1?=
 =?utf-8?B?QnhRdk5wUkJDWFVGVTJueTZvRkJqbnFqcUZScm9WYlFTUlljU04wOWIzWkE0?=
 =?utf-8?B?TnJMeWJXQzh2bmh2V0MyZU4xWXpZZXJNVm05cEVVZTBKTWRYYXlsTXkySTB0?=
 =?utf-8?B?VmxJdGZDUVozR1EvOHFGQk5tRm44VlNIQmR3VWlSYWpKblZDb2E0aHc4VEtk?=
 =?utf-8?B?bnR6WEdpamNiM0NNVlhyNnJuTFc0K3JRUjdOOVIvQnVCU2V3UkU4SVFtdWxk?=
 =?utf-8?B?SUV0SnFuK1pFQjJhMURobU90UDdMSXQ4V25QbnI4aGEzMGt1aWJwa3RNNWxr?=
 =?utf-8?B?ZW12UmJ0UmU5WXJsNU9xUjBUQTlvdUdHZHZTYzR3c2lTanlSdXhWaTlzZjlk?=
 =?utf-8?B?bEJjTEU3NUlwanpKVDJmWnNtRzI0M0RIck5xL2tYYkYwbGI5RGxaV2h4cS9q?=
 =?utf-8?B?QmJxUEY0ejRkbTZwUU9EN2NuZHJjRjZhNjhmRUJBRTRHaXcyRTlWcThOTmtZ?=
 =?utf-8?B?c1lpVDBPMEJobnYwSHpWcW12d05oTG5HOVBMWDRqTGZudzdVcG5DcHR5TGRB?=
 =?utf-8?B?TTM4cTdybDFEU1RZS3c0b1FKbE9sZnNXOEZIWUFSV3dDSXBXMnpNRjJNd3ph?=
 =?utf-8?B?Mm9rdTV1T1VGYkxOR0xwZGxOdHYrNkFoMkpkNGNjc0hQcVhld0RRNGFETDNp?=
 =?utf-8?B?a0k1TEpzWXg1T2c4TVE2eWtOM2wwUitJR0lLWGVtZS8rKzJ2eWlkN1pVR2Z5?=
 =?utf-8?B?NGV5dmhodHFBc2JaalVwaDBqUDJhVm8rRTYremNYUkp1aks4blhBeno5VHM1?=
 =?utf-8?B?ZG9iRVpERXhrclRtTGk2VG1MT3NQaFNud3I4NlBadGxOZ0NUWitYZW1mRldK?=
 =?utf-8?B?aWxSUFdXTUlTY1V2L216QUJwVitnNy9nVnhrbXRWNytISVFMZEhieUprQ1Ar?=
 =?utf-8?B?S2huN3FwZmM4YjlMQkVRZVlNTTIvVHNFV3dHTk1URUV1bHpuRXZqYkI1QXRr?=
 =?utf-8?B?N2dlT25rbmFTMnUxNkpBN0pSV0JhSjF1V0gxR2dITnFlRjJSS2NFak5lWWNI?=
 =?utf-8?B?YnowaDRteGhWZWZuVVJLRjUvSTdJYzdJM0lmQUR5Qnh4ODQxSDhYU3Z5RlJZ?=
 =?utf-8?B?bXVvZzVGRCt6Rlhya0pMNFpFVFNIVkZ3cCt0a053WlQ3VDhFZVdtOEwyZUxu?=
 =?utf-8?B?Rk1FMWYySWtnQ015SDhCSmtKcU1GbTg1MHdwejVYemlYaHVtamxrMHJ0cWpQ?=
 =?utf-8?B?dnMyRjI5RHJyaE9SKzZBSno5WHhZQlE5eUIrQVQvSFlGSGZPUVB5OURGK1pG?=
 =?utf-8?B?V3pLMThrS0NxZmRFaGNHR3Z3cG12amdCU3ltN3VKa2J4U1hvOEtJREp6YndU?=
 =?utf-8?B?a2V6clZBcWlxYW0yM3pUSC9xelhsZDkySGlMQ3JvcXJOeGRPYTNGYy92UHMz?=
 =?utf-8?B?TFJCOW1STEIwRmJ1TnMvOCszR09xd1Z3dG5mdkUvN1g0aThYeW1BcllMdmlW?=
 =?utf-8?B?ZllaQXMzTHJRb09UM2RRaDFKazVSMHhPSXJEWEhkTVFIMnFzWHVVQitTVjhy?=
 =?utf-8?Q?mEaNhFw30zfRR0JsOdKa4GC0/P0QCgKvdS4CZ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f33c64-63f6-42e4-1be3-08df45784b0f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:31:46.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOP1rlYsj2Mr0mazdC6LPvPtJtFU1hgUa5ZoRxPWNNWoduki6505y6cEzb0PMi9iqVrUYJuNAXeXF5gPgBU/nMnsTGCJDLL6j3vpgP3LCE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11645

> Does checking only !rq->online still leave a window during CPU
> deactivation where cpu_active(cpu) is already false while rq->online
> is still set?

Yes. On v6 I answered that the rq->online test would stay as it is. The
next version adds the cpu_active() test you suggest. The refusal then
covers the whole deactivation, so the window is gone.

On the way up, cpu_active() is set before rq->online. So the extra test
changes nothing there.

A write in that window left no wrong state in v7. The rebuild at the end
of sched_cpu_deactivate() resets total_bw and extra_bw. But the comment
says the refusal covers the whole offline, and now it does.

This was checked by reading, not reproduced.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
