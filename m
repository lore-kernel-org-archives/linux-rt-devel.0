Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182695;
	b=sgo59LKa2XN+VZn0drjUTvhgIHDGL6VPo8IH3naVakXwnjDsAwEfZoTgXEXLY9ciy49i
	 cyw6WqTcik7qurqkUfV4+lW7IW3tzkZiGov+gMMkHzfU2bJA+p0pYCyJPAPRXTXy8y35I
	 YDXHGj/0QvHHIC/5HlDZjhr0aDxY+Sv6xpFvZVVRqRwrKDKymrPrz8t7zJ19/wE9Tl25U
	 a3bs/gkFUeGNNWch1vbdaTCIc1vBsRalEcaOsunUrDZq45t37t6P01BW/ahRM2I0Fumao
	 myX9HDVBV0Kh5tsJP7R3OBo0/CoYaTDsGjSb4hI35D39Cea4iA4Wx/oLS/gbuu07AeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182695;
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
	bh=b55ASP5RoZ3EndgqFSNWcWAFL+HcyGuOfpErXnGal88=;
	b=3nyEaA4ODHaynF2unAFbHankLnHbyTWkUe0c5AXXy//9qnL4W4s21w0F/BUDddjIxfuL
	 en4wYt+3cbqBcGuxGhZM5QgmIgkgaMwIywGE4cVJPx2W+SD+8dLeNBHkjIGC0R5Q/+lqG
	 Lta7686Qtq4UXYM8N8OULmftX0q/1XFjeWCWCDbZBf30DLo2FJdohAaKj7lartDinZ4Nb
	 vhFDuvpOalOvIV6F+zvKpnM3zPJSNSWg9jS8EkcwvHuQRya/cHIxQs1FOfMmcn8m5CMNX
	 UMCjdiWn1NrJG/6ZX/OCYfHbkdJ8r39qTchlysLQZzEm9MhGT9QAawBZGPiddpN+zeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Q4U98P88;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.115
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022115.outbound.protection.outlook.com [40.107.193.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE160A260C;
	Fri, 20 Nov 2026 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EE160A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Q4U98P88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKraQCI9/7GINThgPH+i2KxYuAsrihydZvmpNf0oaBvF3Cr1CUkFrhAZp2GMCcVpRYVmxPBQBuTDgkuzhno/iNyWsGYF2DU09FTNvEy1bNFlqLQbTmG1yQDz81ak3JnxBjJGBohtRc3EVzW2M4ptGuBY77HmQ5l9qZiV9kjyBwpCW/MDleXcqXDB0ATh7zwRxdV6auJtvOOrc2Ngs2Fahfd4UlTz7qE2RgkXORH9qqIEDaDKwkGwN8W8yTYYbvNogzrA+Mi3bIf6JXPYadNvAlIutyH8PkQYYVPJbXb/rNde9rV97TLEoebaunLFpu0TyAh6hlmq8m44Lvtj5FM9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b55ASP5RoZ3EndgqFSNWcWAFL+HcyGuOfpErXnGal88=;
 b=U9UdtMDz2w0a9rS9g1StR8oD96o7eVjTUg6KgkGp11x+XoUB9Pb6GyyO52Qn88yfWW7k63FHB5mMJV0B3umO4z9w52AQYGy8HRGu1OVY3Ud48eYi82lCNnF5SqE+nCD0/jZ0r3p9ZVc7509dm0KSklqqL8DthSvcbk4+JP1J9dZHymFU2gS3Ur5pQo5kisMSQu1GFxEAb53HSW2FkqVNrqUBn4l8+xcOKB38vOYDhtRrusRR4rbOx6PK/FBvimZSn8UDCgwG09tLmkHjbGCihag1/PRvW4gEV4qPkRHIvxDk5bWWfNZNY8fn5oN3+zjxGXXQjNNJbg0+mfvlZ2ElGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b55ASP5RoZ3EndgqFSNWcWAFL+HcyGuOfpErXnGal88=;
 b=Q4U98P88NXTpaC9AoKTJVfJrba5+zTdPVE4lmyL33ej/n7YwcNH+i2z7/Rh7zFWy2NgWAz0KeymL41hpVcCKQ2ppK+NTgtv8tgVWF8O8faPBRWPvw8TcJrP5EqX9s1F60BK0vqN2eHfaSKDQju28C+ToSJhmsZ4jrxGOqOcWS83459GhtUiqtEFW864W4BH3Si6Po+j1dJ73DzDqEWI336dwkAs9p4GruNcdsZK4hrkQ6B994CXWStrl3PjtzhvkerMSyW9qH3ta3y9zIE9zy0OCcRDk2Y/EecoF67elQ1/8xzrb3yE0sxkrFxOo3I/nM7XAnOvOaF+wFTBpFpoXkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB165033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:51:33 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:51:33 +0000
Message-ID: <c7877bf6-7951-4a58-9315-89ea52b3bdc2@efficios.com>
Date: Fri, 20 Nov 2026 08:51:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/33] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b9c82782e39a90f12daa052f5189fbfc97e2eb11.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224041@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224041@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::34) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB165033:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfe8be7-2f20-41e6-3723-08df470d632b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|261009223027099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7F5nDJIrajz73+W4l94qd9jp302xvxd6sExLFMsqNixGHNtrJ3a6/ngzsm4ylBJcdmu93V77L1LjWTJaI1rvNfNMGGirPR4GjghGaw7Me2pJfCjwilvRb7+rEZlQzx3pQIcDtnDhNKpaQOfSSN8M+eACYOFkH0pYN0wiJMDNthWCGC7jpnlvWOdQvslxWfZt4uY56ynAyLuegWLEKrnrkgszg88dJkdW+jHBq7ZaDBGaUQikrGr+DPUQzKYoXDar52NshIJoTNArungLmfTR9lePgCx7iijkzKquDS0OhFUwzKOBG2fOmMHNouJchj03V1RuAXvI3Ey2SRNtcLjXN2WCzsExc7OzZSdPOWfICmnrOem8TDftN9U/FOL/5nDEZEhN6snrI7qBWjlPOmRAUYOYJe9MHMhcPlPDCm29aDhwHpbfQ3EEkbDNa+lPzFxgPSFDzM/Q49ldF/md2UvBCGWLfcjFTTk/W6xbTKZQMwdKgDUzA+pairkUuK+cmP9wPINBymCQWqIJj8yOZi8IIkeNIaa8XrWKyuhClI7aqooHI3ITG4x33bv7OlbVAlE7HA0pP1T13NExsSo4YnLXs9Qg5BeB6OX2jmVBt9GVnZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(261009223027099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlRNMHV4Q0xBWEZGa1RhRlloVThXdXpSaVNNV2d1WWc2cHVVV0lYaTFTSUNl?=
 =?utf-8?B?QkVDakU0S3Q0L3hwemFLRk9qSW0xR2NGTjlEcmJrcUl2R0d2eGZqRVFscFBx?=
 =?utf-8?B?dkl2bEJlSEJPbWxlVEE0RW5nNUVaeEtuL3lhNEdxYXA4VVRPcC93Ri80SG1t?=
 =?utf-8?B?ZDlCMTNkbzZwTktKc1lRS0JhYmxQalB6ZVNQb2xIejNBTDAyeHg5ZEZRRVp1?=
 =?utf-8?B?VUJ0TDBqSTdvczNDVzJnbUtrUzZRbmZFbHBETWd0UVNHdTFrc0RnVFhydGky?=
 =?utf-8?B?aGJ0VGlCWTZpZ0FyVDRmeS9hbnRXRVYwWXI3WWpkb2hIOTNVUGFHN015bUZD?=
 =?utf-8?B?STJUNmlOV0tTSTNwUVcvdUVLZVZLTldPZHRwTllDUnllYkxHNlpXUS8zZTBK?=
 =?utf-8?B?R0h1ejgzTzg3RlBWL2dFNGkydFJIaHZVQ2hSZE1uN0QxWVhKNVBTOGhhMkpj?=
 =?utf-8?B?MUc3N0E4YTJ6N0VUOXNnNEZpK2czTmFxdVlLdkZzOFc2MldGQi9CZWhWT2ln?=
 =?utf-8?B?N1ZNMWdFblVBd3pwVGxSUktaL3JvUEpkS25OMHN4QmZ2Sks4OHlpM2JuWE9m?=
 =?utf-8?B?WndLQm5wVDhCUmdkTHZTRHNHMGJoYWg1NVVJWkNnQnlCdGQ5emVuMURRc1Vy?=
 =?utf-8?B?V1QyWXpzMWpqNGI0N3lqRCtxOFROa0NuME9VVWRheHFkK1U0dDErYUdLT09L?=
 =?utf-8?B?NlN2R0x5QmJWNytXdlAwbkJUMEhLMWovUlZTN2xoTmJrSTNlL0lFMWpKS1Yv?=
 =?utf-8?B?ek5HSDdxTlpkVXBnU2FWSnhUOGNyL2NCVDkrZ0dTTFdoN0pUM29aWVF6Mk9H?=
 =?utf-8?B?S0ZFai8yUnlWYUJWRUQ1K2ZDQ2NsWDZucDlWSzhpMnZBM1Uxb09hem4zTEdM?=
 =?utf-8?B?ZkJTVERKaDBQSXpGVW40M2FiQkVYNGxWeEZNc0NZdWdybmlWdWRDc2FPVXVt?=
 =?utf-8?B?TExkcGg3NHU4SUQ3VUc0Q1Y4dUxZV3BnaTd6NmlCci9GMERjQ1h5MlRTRHps?=
 =?utf-8?B?M1RBdUxiSTJvMkdzM25xQVo0VDYrOGo4WTlNSGpGelh5djZvcU56RE9sNHI5?=
 =?utf-8?B?QXR4RWdSd3hSRnpmTjI5ZlV6Y0sycndvdmZyblUxM29OaVpmMVAzM0M3SktH?=
 =?utf-8?B?Z1BhNFd2UGJVK2NEL3R4b0JQZ2Q3UXo4WUtldDJTc1gwcy9tV1lkanNWckti?=
 =?utf-8?B?YUxoRnBXUHpwL2gyazlyQ3ZTWjAwMlp2Y3pHb2ttbkpYM0VqekhDbm5ad2Zw?=
 =?utf-8?B?cElQQmJCNS9NWkpZTEIvSk5MKzc1NVRCQllsQ0ZUcm9NbnBhMHhEdmxjQXcr?=
 =?utf-8?B?RHhlZU1jeSt0aWI5c0psSVp6c3NBNFNBNUd5L2F3cnFtTFBQTUlCRkFjQWh4?=
 =?utf-8?B?SWZRZitRTzl2aTFDODA3UTFZOG5maDFOaCsvVXhad0xLZjZJRVpqblJ0c2ZS?=
 =?utf-8?B?aG9GeE14S3VNTVQ4SzFkbFk5R3dFQ3NiOEtPb3RLallabzVMUjVnWG9lQlpn?=
 =?utf-8?B?Ylc2L29XSW9pbUZzQ1Z4SW5pOExKd2ErYXU1TlMvOTI1YklwZm1MTTFxemUz?=
 =?utf-8?B?OWRzclBIVGlUa2puWDhoU1VqRDZaQndHYUJyeUlYQmtDYzVWc3FidzBJb0tF?=
 =?utf-8?B?YlRwcWZ6UVlOamIzTXZmZDRNSjBnTGRRb05XcDZqaVBDT09yVERCS05HMU55?=
 =?utf-8?B?eE80NmZBOTFJdkVCR21HWG1wS1RFWTRWUThGWXVKb2c0NU5EOTJ3RnhJWDA4?=
 =?utf-8?B?akI3bG5BeEdCa2xXMFY5ODBNcTBteHhzV3B5amJtWHhEVGFIQkNKRklRcWRL?=
 =?utf-8?B?UEs3YnMwRFlKeStzMDl3QXhXUDhrUGp6YVNXZkZyVy9VbTNHaFZvamlONkJZ?=
 =?utf-8?B?NzRNQ0lveG52Zi82aEl0TktqOTcvTW4rYWVYbmQzS2ZUbGF4MjhkQ2ltR1ZT?=
 =?utf-8?B?bnZmMUl3S2pyUnVhZDdLT0lxeEFjU1JvQWkxeVd5Snh2bFRNT1doS3kxY05M?=
 =?utf-8?B?T3BDbHFXRzdGc0pqd0g3Vmk2L1d0UTVFZnF6K2xuaWhNMnBFWG4zUTlzdnI4?=
 =?utf-8?B?alVWNjVCYXp1UW9hVG83d0l4dHJZa1FtWUVvbkthQW53Z1lDMHVTWXRJdSt2?=
 =?utf-8?B?QVFZd0tmU1Z2WE5ZOEJhRVZpRklJUVlZcVdGQ1ZwcnIrV0VNQTZyR0IyNHJm?=
 =?utf-8?B?cEJ1eXA3bjE1T2k3aG1IS3lHeFpjUXYyMzZNRkJmRWp3L0xZQnB6NDBsckJp?=
 =?utf-8?B?Q3VxOWZZMHdtQnNqV3lMeEg4MDFCejYvSW93U1NlVU1KYjhrK1JSZ1FER0t3?=
 =?utf-8?B?K0NadFhJUzNEek5yb2Y2SEZLNEdiR00wSDZRVDB1bUFYUFJCZXRVa2N5MmZ2?=
 =?utf-8?Q?2ZNi8HhZNpPoS3jiw9QyHd0HPGIXWtWIy9tHI?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfe8be7-2f20-41e6-3723-08df470d632b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:51:33.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC+TXNwqoqHSN+j/nlcm7ZyrDe5HajebjvQKOujnLfCJh3hwG7SRn6T9woua+vA4I3j+b5pceKW69yVQ2JtssCfbiCTEgO3P83O9sDZp2CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB165033

> Can dl_tasks_keep_without() here reject a valid partition recovery with
> PERR_DLTASK because the root domains have not been rebuilt yet?

Yes, by reading. The refusal is false: the child partition stays invalid
with PERR_DLTASK until its next update. No bandwidth is lost. A fix needs
the span of the root domain that the rebuild will make. I would rather
do it in a follow-up.

> Does dl_task_keeps_root_domain() mismatch cpuset_update_tasks_cpumask() when
> offline CPUs are present in top_cpuset?

Mostly not. The span is normally inside cpus_mask, and cpus_mask inside
the user mask. If the user mask has no active CPU of the new mask, the
span has none either, and the check refuses. Your case needs a root
domain that grew after the affinity was set. set_cpus_allowed_ptr() then
fails with EINVAL, and the task keeps its old mask.
cpuset_update_tasks_cpumask() ignores that error on v7.4-rc2 too.

The test of your last paragraph can only refuse more often, never less.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
