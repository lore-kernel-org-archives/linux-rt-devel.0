Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442252;
	b=razGqKfO1HJii1ikrb5rimnSf5lr3LpS+3sQLj8n00rqDGEn8q5mEGVr4jCyR2o2WqIS
	 E8/Hk1rdoLzHz24jaNhYhiJpZ33FQBscJrsmTR1xQ9sq/MVJos/0i+Kome/BijW8fmhF4
	 Df22V0BQO3gqZBBQyRH4NJ9CbZ1HQ0L2THt616utuTlRe6CeM9R3ecF1Ih6Q36khgMeXh
	 YdIVuvSFPNqnDDsA7TRCitkXkOCeH6YNd/Q+pGGL//P6QO1s6TzFapyGsz4Rd3ByXqLbx
	 DtEfDrVwuQyopd1R7ZgB/VOHCpQUeA0u1/ExSrXu6jn6bEQDUdzRYJG2ROZoEIUx3Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442252;
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
	bh=/dY9JgruKbWx4GdY/zRzxoDiMmuXM1kyEY9Ljq27QPc=;
	b=UyGg1TLVd5d87PKQQjyfLa6iUogzvgwmbSyOa525C+giw0XHOiPG5GLMG7M71PdBliaW
	 0MkFA4fFaep/1Mo9ceEOGr/meVTmX+F134gXi3qilxws4mGO3HxxjZ0a9W0Vg3cSdhO5y
	 +T2WL5sExP3qqmUbkIfS4AH0dtOR21UVfUveEnp6p/v1q8vDjDmD6A/GbdJhPzVQRAYBs
	 MoLxNv0LCZR4EjbmiIpx4htQKokSU+/+qrIC1VbMzKA/hlwNi4XTYISo3WNXhOHIAkN24
	 KPTgSS0Wv4DHXJ5g8gPzN9/RjtUbFKPRxdxQan3m763pgq04hiLbbnpj8MKXkD/i4Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bc5ftud9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.111
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020111.outbound.protection.outlook.com [52.101.189.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808E606A31A;
	Mon, 23 Nov 2026 13:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8808E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Bc5ftud9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0pKpZscZz9kSI8vzG4iBV9vc3cnIwRL4dUPR7gdSE5BOGW3IBe6aaDI9cUVDonSejS2YSmjUmLQRJNq8OeIChEfLvTOvqEaHR/4GGIwICTuyfJtKDMYh14RqoNl3NE2pHBtHTbiGaughLHpTQhp6EP4XbqSwNkSYhbVq0D6/V9gOFfh4fqm6AjbDq5W3OWf2q7vW1WQ8Bc1sMN7NKQTMDq99vpavvhuK2FR7D+wiIVDb/VgfM2cgipsA96SLUGaz19FejfQWZ78RgiKrzlt3rlG3/mdNXY7RDnzBxF5crwNCWdevHQofY2OC2AA5BIZHnwoTYC8EMIn0FUarQaWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dY9JgruKbWx4GdY/zRzxoDiMmuXM1kyEY9Ljq27QPc=;
 b=U57gdq1nrGUm+tMpDVFPTmqVX+ve+dZfG+BSqUGkg3DeqmGlaN3BTjGgfAjR58Rb/bIC4gGT1Oez2Z3AEwCK+j57zk3UeSuXLgKq8ysLJXse9ZKtxFWkcv7ze1KmDmV9sJqSR+d17zxtMY+ICwULKl7XMmVl5QYPIZxbAHH0yjMUp0aZyJ4UBZ/1/sxuYu560x4dAX7/y9NqUK9WmPmTX2sBaC2GaXFC1836FygfxZ4/0EnO32KVDb3CAaEWi7eQUX2nAafggyyE4TBEr1yLDaWcpAYKaq3WlZG8JLgFqN6jj5qzdOl3UwC82YaulJL1u825X4T9n/rhcGpoAws3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dY9JgruKbWx4GdY/zRzxoDiMmuXM1kyEY9Ljq27QPc=;
 b=Bc5ftud9O3dK6K4GHL8yiCR8vmcwwo3H7fCXBw+M3r4TQM/4eXeosc+7aETD8MQrCo4VqINEfa66ZLHVtKdsa3rTQQe9ACuH9xVEYFrjlDYBkbgpwiXIvzXXJ+PwffvxLXE43+UByq6zszlrj/iClzAP/xR07/ydSCH8LsYrZK+ARKRO2oSV7JZof4yFZsl0o/DxacNWNq/e5w9Ol5B0/wOlPjBpQ1sE7bs3BmZYviOR9w5fO+t68B1tYIvzZkJOKqF5y16tzxMaemrYzIlCkr8TtHt2QJEUk1OmaE3cRmIXOXw23QcUWk731dG3ULvd+h4xwT91Tzy4dGL9jQj/Zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:57:28 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:57:28 +0000
Message-ID: <043dbfe8-f1a0-46f0-b4eb-373a1abeb7f4@efficios.com>
Date: Mon, 23 Nov 2026 08:57:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/40] sched/deadline: Make a rebuild count a task in
 the root domain it runs in
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <c7c27e2c74c13bb8580f84ac9ed12a5a8001947a.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226138@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226138@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4816464a-9189-4694-a4df-08df4969b5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|261022075727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	A9hRY001stif9dBU4WkwhP32YJv7T06Tt7eGmYKFky06PWMCyE4FON6oH6bZIkG9tUXnh0yXLA7YJkBjPZCzQBn+4rG36hgPspz+Fb+9pA96aWz6LS6+wvqezW6A8RB1/OV9FBXMwJSZxTBTxsz6RVX2eC0dP+rnzXHvj7CC+ySSwTXFAlIX2m6XeRokWGEmA/dGMqXlzB06VxQ4P0RLb8br4uKH0ZIgSFgSAxEf6LA/OzMLAXfosCxP7oDA9ESahcenLvzg5qnguggPQ6NSbUrvffj+Rde329ipHzz2DSiionj9FSsYFB+68mhIGYQt+X05XdzzhoiYpLvtvLPFC/6xlspLcpOkO/0CemVkwwunnV2Au0NKCakJ5h50iNS/eQr/Wk24yNR8bwDAChQmUVIKvNJxLrwBEreO/Q+vvK/X+DOFOwp3iMwJAXLA5Bp4Op84bGH6r7VQvvVU7/+Q/Al4ssHRrC+fb/QWBhinJf/ZpS9aFPDbThNeXvzU5j1a/39IREiPlSkCi7ZEft+2/WZknfGreqmUHKqdYB6iByeXd4hRpTwpZt1T6kR85dELYbEAR8QZbRNYUOjuJRVj4zuVTl8C43LO7fJLYZBqRMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022075727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNLWFc1Z0dpKzZBT205MFdqUFgyQXFtcjZhN2l2dEg4NHEydWsyakdKbi9Q?=
 =?utf-8?B?VVNNdmk2aFMvUTVVUExLeDcrb3VsTC92QkFaZFdpN0cwN0xiRjFicjlialJL?=
 =?utf-8?B?bVJiUlR1OWdWWGgrbDljb04yYS84MlFjR2ZjVDl2RDNieVdtNm9vV3dlU0xa?=
 =?utf-8?B?VzVlWGpDNVJFTzBjVUtYOXlFZjZQQzMxOXF1aGE3TzgwRDBST2xiM200bG9s?=
 =?utf-8?B?cmU5RDUxZjFOT2hDbGFBUHpGZDJBN2dnQmN3S24xQ1oxSXNzZmV2T3VxTUND?=
 =?utf-8?B?b2tIakVFYitkU1Y0aHo2YzFqR3pZNG1Tb2dnb2dkSnVJUDk4ckNnOW5xSFM2?=
 =?utf-8?B?VXk4b0gxU3dlVk1HYjZJeGZXZm0xTWE4Zm5rcURjOGp1KzdvNFhoN2phSFR3?=
 =?utf-8?B?WHNzcDEvYmVjSmVKMkpWWThzK0VzY1JQYVBGa21NMEYwZDNUQUlHWkNqeUNH?=
 =?utf-8?B?aVlrUEpUbkxyN0JTVEFRN0p1UW5YR1pQcDF2RmpFRHJ4ZEoxUG4xOEx4OHJR?=
 =?utf-8?B?ZzBaY2NkV1loUldyVnBpR0NHVjIweUJOTE4wRDlNeUFqaVhFcjUzN2FUeWJC?=
 =?utf-8?B?VVhlTXdZSGkyb2haY0FwQVVoenhKbjBDSitSajZxM04vT3lnVTRXWk1zWThu?=
 =?utf-8?B?TUNwMW5GL2d5bDFrMmI5cWVQdmZlMW1vbDR6VWlCSmh1VE9yR2RTR09uRmlK?=
 =?utf-8?B?R2NFcElqMDE3UFVtWG15dmh1NGgrNndzY0gvWExpa1VZY0ZIVXJuWWUzTWtn?=
 =?utf-8?B?REtla2o2aUNIMEN3YUlESjdLT0dyaHhnbHh2QWx5RXlyK2krcE9UeUd0ZGNB?=
 =?utf-8?B?cWNlZkFwWU1ENnVQT0VQbjNRa1pUV3N4Q0VTMU9Wb3dsS2wxNFFSZXh1Wjhy?=
 =?utf-8?B?YytnODlMQTRqRER5L21sSnhLbDB2Slo5Z0puTVRQeFhhU242WWppS0FpYjJM?=
 =?utf-8?B?cFZwS3ZNME9GZjlsV251TnNYNmRsd2ZTRjlsUExNVlJOMllJRHR4dmJoRkY5?=
 =?utf-8?B?ZWtIQS94dFJVS09TS3g0L2tTUytONUJ6U0gyWDZmR3hwOUhHamsvb0RxT2Zp?=
 =?utf-8?B?cWFQNmN0L1pmYUU3end5d0tka1U5bURMNEI3WHk4Umpubk9BWkZ0UjBib3Ba?=
 =?utf-8?B?cE1OampHMFZwKzAzT0VHRkFsNUhjeXFSb0tBVzJ5MEd6Z0trVDJYN1lIa0Mr?=
 =?utf-8?B?U3l2Y3VOYkF6cTBWL3h3clJpaDMySG41RUtsZXhGNGlseWFwamMvRXlRbkdO?=
 =?utf-8?B?amRvM2plSjZ0WDFYTGgzRXB1QWl5T1RMVi9RQWZBQjJTQXlEY21MTm4zRmtX?=
 =?utf-8?B?SjQ3ajUrOWorQ3NEUmpmMjEyc0xsaEVNZ0lPOVAxMnRheHlVMnRpMXJUakl3?=
 =?utf-8?B?UCttT3phZXVSeWRKcVdDd2NZa3BpQmliSU9CbTNvcHV4Z0d1QnpBUS9qTnhm?=
 =?utf-8?B?K0s3YzNTWkhjbUVHVTdjVUc4anY0TDY2Y3oxMUJXRGVVbUpoNVVETlY4dHpx?=
 =?utf-8?B?NWlvblZmZ3E0TUFkMFI4NURxYStnRkUweDJFNDVpR1FqQkZ5WnBOZU4yL3dh?=
 =?utf-8?B?b3g4akZNVmduUkV2MzlJWkxFSXdoeXlvSHB6R2VOZ1Qza2crTHZLYkRXdFpi?=
 =?utf-8?B?WXYzcEN5Q3g1eGZGbysrN2ZTV1pKSG5VVUJncExrNEZGc0wxMDltTXR1WkIv?=
 =?utf-8?B?d2UrbFNQbUhZWW9saDk2Sjd1aDhzRThjdXBDeUhWczlzTTB2clV4ZW5QQjF3?=
 =?utf-8?B?RWl0Mm0waVJma1QxS3Z3cU1XRXE1N1pZQ1pRcFBzcVVGTS9wWU1VemMvb214?=
 =?utf-8?B?OTRveFRhK2Y0Uk1Dd3NCdVlBd1d0SFFxZm5aQWpLTzBpcFl1NDVhNWF5d2lr?=
 =?utf-8?B?WVdmcUJRZnRUdHF5ejd6RlY4Z2NiRi95b0tVaHI5VUdBRVYrRmhtNUpXVGZC?=
 =?utf-8?B?YUg4Q3pFRmp1OU4vczBDYTNvenREZk50VHc0blllODR3alN3dG1aSmttTXRs?=
 =?utf-8?B?QWZ2V2o3TEZlSGk2OUFQNTlObmpMZlFVVHZpMzgxLytYTFVBbVVRTWxYeHlW?=
 =?utf-8?B?VGZpcGRmRlVKUHEyQmZKaVMrKzZNRmM1dExoZkc0UWllc2VvZDRCcEVmQjhv?=
 =?utf-8?B?SHpJZEZTMndVWkRBUjVpczRUL2hIWUVXZEVTR1JLZ0E4Y0lkTFVqSjk3SGQ0?=
 =?utf-8?B?T014ZGhQUzRIbExxVXN6M3p0eXNqQTRNL25HSThWeGRubGNHbVFIT3dBRW1y?=
 =?utf-8?B?WXY3Y0NrQlNrYXFsWnVKcER0eUlJNVpzRFJ0aWV0eU90ODNIT1Zza1RXQ280?=
 =?utf-8?B?K1BYY2FaczlYdmk0dUFxZkhKd3VTbzdRc01zZFptRmlsZzlNU0s0U1ExN2NJ?=
 =?utf-8?Q?uqyyS35cP3s/wJoU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4816464a-9189-4694-a4df-08df4969b5f7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:57:28.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+207Cfu1+Vf+BioVon5lpnak6YbILQwhw92BCzM0Cb9JB9Ug7SfPMxaJAzke3qeIChI/V2x+KUZJEHs3xT5cgUsmeZg8D8259pEir0TnMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5199

> Can this early return drop the departing bandwidth of a task that was 
> migrated outside its mask by dl_task_offline_migration() and exited
> during the rebuild?

Yes, by reading. It needs admission control off, every CPU of the mask
offline, and an exit during the rebuild. In v11, the check for a task
with no active CPU will come after the check for a departed task, under
dl_departed_lock. A departed task will then be counted on the CPU
recorded with it. No case will test it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
