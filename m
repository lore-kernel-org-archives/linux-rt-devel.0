Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104397;
	b=G+FOIX2l1eTYvaRbss2ffXdrtWr6ddp+GKArR1DGy/ssv6CQabbRyQn629NfkyJ1vUlv
	 TrUfxjgP/8itnNDrm/36d5Udu2Dk60E8gHNyYoAEp4Eh6spChle+InTEMNFSWMc0J/i+R
	 7AHg7sG4u5+fQCto4oM9kg2VHFDDsCYoikzW9dd2T7gr/Sg+6u5tnw4vhDrNBhR56i9XJ
	 1ESNNUEnNJytbgLdxpV4HRNL45ScxRmou6nON3aiySSxnbRKkq3CCKQrJq7Xd2k3baJEY
	 D5TEYPHoN/uE5cHZ8qyWm7v43VztuZrWkLOwQ5nkL6pVMevfEE8Dq5lpI99byIbTR8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104397;
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
	bh=I3UisMcDDOYeeMOUpHnKHfy2waS3RQAfj+YEIUvj1YM=;
	b=lve2T6nFfmBjBC43q1y6f68m+W3TDD5UUoje5h4Zpp0lOLS4M6lOHpcfOPEV6OMJJykJ
	 XJf7o+MJY6d7JU2p4Hr41e36eh8ruB/EJAGo2JyNszV2Hd706HVYjh9wTsxBt0Us7AFwl
	 Isvh3Ki4ZWrRu+1vAnlBGYm7eKud1jqvU3pM6kU5SAKKEMan9BH5kmM+GtQNiOS3jxH0W
	 tBD51Bp8t05PBbcdvowoKlmBZcGTi14+wJN1jqpT/wTddSTGMXq4bEy0dCbQFZqfQ9NHr
	 RPHOqxqBNh2YB/8hXxKtX47OxwkDYqfQsGx1Ui2dQgkDlHwzh3kopL0epFfHMKcrrOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GOcPcC8N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.119
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020119.outbound.protection.outlook.com [52.101.189.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6247606A326;
	Thu, 19 Nov 2026 16:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6247606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=GOcPcC8N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkXcAubi7eSHPzioPJPDn4UCMBHl/sku0T+aCsFx29ucS8Qlr1E+s7W1z5fhZcxNdGxzWc3qGwexpPCrhunpEik22bOzYHSkbMrE45t4+mi5Dn3XqP02J0IZmuWCpz5lqw7QyIJV4Pz9W17vqUF2EapPveNKFCwNeJQqwOVhzi9SWqnZFCoGr7SUk2BeM4NXy758pHeUm2VI4+Zfo14JeavITxnCC5xLQP5qxpfbIJ7LOTxXOW+A3FDf17+gjqfWpMpeFfWCg+XYn16Iw8SuWngaSFi6pv2JMFKiMcejXnmQp5+OkCwqD58isc575J4P/WseRFp8uazwxB61Zsku/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3UisMcDDOYeeMOUpHnKHfy2waS3RQAfj+YEIUvj1YM=;
 b=ydkAuLk+1MKpwYZZiW1pGt7nuTkrXv+amDwyDcWP5H+meTYiemU9AYpK1+9/3T8fJkKJz2K+cqaphRDN2UMDXRnhMZIqBtY2KNNdJtGTEN2uH/HC+eaCvFMp05KOXOaZ1IqyJsP1ZBmr9G5tjkT1PVVoS7/S7FNlkKF0a5sQDWqivL8E4BmcYXPG1GH+e2iDyrZXPALIB5SAcwRm7eJzY3KV4PdeTvsNOcwBTyUnwpfz7A7JwTTANRMdeVHu/PJpCamdJPtXyPk2Jhsi6/W+X7hwAyN9TpLPC7SY+Hq21BFw7djzgiOoGbEbbngWI8xocjfqMTiE199zTSJLA4TixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3UisMcDDOYeeMOUpHnKHfy2waS3RQAfj+YEIUvj1YM=;
 b=GOcPcC8NzCkIieS1HPcUciLsFlJW/oUBiAWIuqo3Bxrrec3lHonnEQELY0jc/fo2oM9SXgNYYjsEjp2IK2U425+uC2hfq8XEzGi+Tzy+SPYJPqZlPx0ZgzFBHWnweO1M1mh7E8oX+c4Fxp9dN5hF/7xwm6E3RycoVW12iAjFRjNk2cJxZeOH4mlhJAXQhA/nKinUKdxZSyFA/JRXecK+TAos3+mKtKLk/AN7IYdaoAbAoNv86V/FGBwaFQ0I2iCvmRXcPS0k1NdQS5ULhUQ/yVVduj+NQU9sGzyc4UMCYROmJBwurjHwKGP9vUadfsYwD0x3qF/o7Cl3uBkrBLs4cw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:bc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:06:31 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 16:06:31 +0000
Message-ID: <5b84b238-d234-49b8-a6bb-4b43d0d811f4@efficios.com>
Date: Thu, 19 Nov 2026 11:06:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] sched/deadline: Reset the deadline and the
 runtime with the parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795092090.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-223274@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-223274@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: b87c301f-562a-4281-130d-08df465713b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	e+7xgNLDfDdxfZ5zXzbDStf+8oerEVqhR1MaPRuOuyKzvg9V6KmDF7ygOetmPyBRQLumYntknrdC2wIDAtphdhgyNWiOUYi6LsTzcuSvXwyxLAMgJlIsq5QTpeytp8iSV7miyl/BEMp7q1tf0ddT5wPDxiNd5AIZxYQRfjsidnC3P1FX0CDfXnZDh/6owKQIFcHdSTVD7kJRKJRp4E/HZEgEjsM6LfIZrWb5GooOVO6oxXqEc/q4wAvCvFBH69VnOt25GA0g6sTftqPZ5k/DSBCWIoyQu4DvsiVJmtpFYvJNoHTDNA7+70ZZKsxeMkYzOQo5jsNwN19C8YKA1y/xg8JGDKckqOk8kxw0sI1r797G14NTYgEPIc7mm49AvBHFz3AHru14ULTFbI6qRbPYE3c8Jwfpp13sK+nA5oxDUI47izdeVKMLVe50WO393M0v94Aaquw5jlo1Cssh7NGbTjKtVTCuyLo1gHvLIUkfxChhZlAZSeHzIwk6fvHszrncRMVZ6VO0dPBZxx4NOVUHTcayGvZxJ+YsfEQwJVExeg0fhGC5z49lkx7geQ9Qc5t3bOtTR2J3xQNaNO3JHG/q0zMke+0/0JzpYW4w2IJiubk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkFNTlllbXRiNUJ5TXV5TDk4enlhK2tEU3JQL0VscHNOUDIxSG9id0RmUE82?=
 =?utf-8?B?b210YzF5UndwbnZVQjdreG8rdlVEL3F5Q1NtbmI4aXRYNnlDZnFpMXgwYkJ6?=
 =?utf-8?B?eTVFYWNrOFdyY0tlOEN3UW5xcFp0RFZZT3JsRzFnemQ3cG5RNTNYaHo5STZw?=
 =?utf-8?B?N2VObDc1eXpxRVh6WUxPUG9adWltR2EySVNFMi9ySE96RnNOdFpzL1NjS2h0?=
 =?utf-8?B?bXplSk9IQVpvUEVNcFkxOFhSNE9VT0Z5TW1xbXh4L1p5M09VTWIybU9zQ0Ex?=
 =?utf-8?B?cE9QazNPc3I0MGw2NjhMYzh6QUltUjFCRktCbWRSNjhmMUVnSllpZUhoZU1m?=
 =?utf-8?B?ZnhkN251dTVUd2wvSlR0OUFpb09GWHNGaHpmQm9rTHRnYnplakdPZkQzY21V?=
 =?utf-8?B?cGkxYXY1ZjNSbEhLNUNCYWt2N1R0OEJacVVHeStrbHNmY1JkYTFpUnhPVkxW?=
 =?utf-8?B?dlJMdWlnQTBKMk8vMytFYlErNkg1T0crdjBlZVVoc0hUejM3S0dVTmJMS1BV?=
 =?utf-8?B?Z0pPSHErYWdJUElncWRBcVFOcXlMWHNQSkg5V1lBV3Nqd3I3RXRUQ3lFMFAx?=
 =?utf-8?B?cnVVK0dKczd3UzlaelIwTnptQTFZRGNWY2VqWCswckVSQXg4Q0dMSlNyRjho?=
 =?utf-8?B?dFVMOVEzemJYbGlpYUhhYTJOV014ZW56RUZOQlVZSmNNenp6RXFsalN1U1ZL?=
 =?utf-8?B?dW9WaDVMZFkyMGdkMjZGZmU5S29QY1E4alcrc3dPTEhJdzM2b1lwL0xyVXNR?=
 =?utf-8?B?a0xlZXhoZXdrWnZnWGZkOU9lUlRjMWRpdFE2Zk9hbWxqVDRocjI4MUpDdFRO?=
 =?utf-8?B?aDJoMUpHbEMvMXp6emcwUndSU1g3VzJ5b250N1VQZC9xWGxtNERyRGdtemFI?=
 =?utf-8?B?NVNsWlhUelFVMHJURmxtVWFoaEhRT1d5Ui82alRaa2U3WGRYOFFnSWJlWi9Z?=
 =?utf-8?B?aVY4Y0pPMVBpYURRdGN3UzJUVmRVS21zWkxkUmZhN2JWNm9nZlg0aFQ3a2Uy?=
 =?utf-8?B?eDkwZG1jOGRlZmtVN1F0TmtMTVF6VTBydWJEUzY1V1kyUWpIM21OYTBxWUZC?=
 =?utf-8?B?VGVxeEVaK29PZWs2OHVUcUJBSTZidU5kNWNiMks4RTlNakZJT21KbVB2azNW?=
 =?utf-8?B?a2x0TDhiNlVqVVc1czV4SUxHZ0dpMGRad0JneW9OcmQ3RE5MZjRHaEZLalND?=
 =?utf-8?B?RVJ3SnBtOUc5cjZBTG1Kbm05VWQvWERVenJKQm85dWZCSml6enVCL29pZG5P?=
 =?utf-8?B?VDR4OGkvREFZNGpSelNpWWFxcHYzaVdkRWhmWGRtblJBT2NMSnZ3SzhtWEhz?=
 =?utf-8?B?WE82bCtqV1BvVEdzVnBIWHFQN1hhYXBlbXRvcDVkaU81a216dUhPYkg0NjhJ?=
 =?utf-8?B?eVl4SHFUdWxpVXdyTEQ0SFBjdGVCeCtIMWtXaFF5Vjh3V210bU5GRUpmL1NS?=
 =?utf-8?B?em16bXU1M2lIaWtOSE9uaWl0ZFBOOUUzSjM3ZEljTEIxdnQ2L0RvQzFHenUz?=
 =?utf-8?B?cW1tNnU1UFBZbkc4UnNEazFCOGt3OHhwZWF2cVBsZ2RpamM5VUViUDFKbDQ4?=
 =?utf-8?B?V2xRaDl4dm9IRFBUdTNKVkx3c1VuYklDWkJVbGdRa2dKMlhoWVlJMkJyZDYy?=
 =?utf-8?B?M3Myam40a1hsOWFjdkJwR0FBeU5qaitTZFBLTnpPNEZyMUl5QThCbGF3TERQ?=
 =?utf-8?B?VnA5cTNYTUxqckdZQ01pbklRNG9zb0VyblFVb0MrQytBKzRIZlpVei9XUmJB?=
 =?utf-8?B?YVk3ZXJiMEpmVlQzankvQlFXTlNKK3lwVE84UFBYbGdRa0krOWJpT1pDelRa?=
 =?utf-8?B?bzBoYmhFU0N5Y09SZndMb0Q3T21RdFVGMUpueWhDYUowMHMvMzMvbjVkOFF1?=
 =?utf-8?B?K2JmVVBlbUU5L1M1WHpBWnpsTGtnTUI5L3NQVFRBaWE2aU8rbGpVUUdYSUJP?=
 =?utf-8?B?NUVEaDU3U3V2WndMYzErTk1CWkZmREFwSFBMaVJYekw5OXNEdnFkVStDK1Bn?=
 =?utf-8?B?ekUzSG05MVlVdW9aekJqNlhMKzlmdHdPcnppUTlLVVBzM2MxK1JTL1NtODR2?=
 =?utf-8?B?OGtZamtFcTh2SWtYNXIrdTJsUzJNQ3FUUXhLb3F3aWxUcmtXYnRyRFhnU050?=
 =?utf-8?B?ay9WVkwrbk50dG1mZUJRNE4wUHgvcS8rVGNYeGZWckUxZ3RrZ2piL25SYzQ2?=
 =?utf-8?B?OWF3UkljNTBHajNUaW92VTdQTENhVFpKdmQxSFNoTExiRk9YY2xOdk1jUGwy?=
 =?utf-8?B?aWlCaEZwQ2V0S3hYRDVMK2ZzVUtreUdoc3NwMjdGaDV0UE1XQnRUSU5SaDFq?=
 =?utf-8?B?YlM3NUFrWnpzT04zZldvQURocWU3Q092M2l6U2ZCZ2tRUDBxTGtXSzdDNldR?=
 =?utf-8?Q?yWJ9K6bLIydZZVyjDakzYKHKAzGNywMaV0nhf?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87c301f-562a-4281-130d-08df465713b1
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:06:31.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWk/oHgz6pYpx2G/mRxnQ7AiKW+IJPspifgXfKuUTZTguLMR+2yeRdmekjAW1ec9D6ahLUY+YHoiy0p3Dn9ZmFCAZl35Zx6RO2Zxv7Cn0/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9061

> Can a task still keep its donor's runtime and deadline after a priority
> inheritance deboost when p->dl.dl_runtime is non-zero?

Yes, by reading. This is older than this patch, and the second series
fixes it:
- "sched/deadline: Reset the donor's runtime at a deboost in the class"
  starts a new period at the deboost when the boost refilled the
  runtime from the donor. Its message names this sched_setattr() case.
- "sched/deadline: Check the runtime of a task whose parameters change"
  checks the new parameters at the deboost.
- "sched/deadline: Count the bandwidth a boosted task is given" adds
  the bandwidth to this_bw for a task that sleeps during the
  sched_setattr().

> Similarly, if a former SCHED_DEADLINE task is PI-boosted and deboosted
> before its 0-lag inactive_timer fires, switched_to_dl() cancels
> inactive_timer while p->dl.dl_runtime is still non-zero.  On deboost,
> switched_from_dl() skips the !p->dl.dl_runtime reset and passes the
> donor's deadline and runtime to task_non_contending().

Right, with one correction. The boost keeps the task's own runtime and
deadline. replenish_dl_entity() copies the donor's only for a task with
no parameters. The donor's values come in when the boosted task runs out
of runtime and is refilled from the donor. The 0-lag time then mixes
them with the task's own parameters. The bandwidth is released too early
or too late. This is older than this patch too.

v8 of the second series will add "sched/deadline: Start a period at a
deboost out of the class". After a refill from the donor,
switched_from_dl() starts a period of the task's own, as the deboost in
the class does. The bandwidth is then released at once. Its new case,
deboost_out_after_donor_refill, failed in 40 runs of 40 without it.

> Does clearing deadline, runtime, and dl_throttled here without canceling
> dl_se->dl_timer leave a stale replenishment timer armed for the old
> period?

Right, and older than this patch. The second series fixes it in
"sched/deadline: Cancel the replenishment timer with the parameters".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
