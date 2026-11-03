Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709663;
	b=U7VAwSPw/DOrW9lFiN+ObktCVbj5Yu42pz9N0p2B/fk94YMnbqnnpzjZUvCEtFIOiHk+
	 MNtjqB31lxlLzk7Y6aH4bmaCeZ02nHbKRp5zNamn73Sz+eRftnIIDiyCgVGhyDd7n9avB
	 jMsvkAW00V2QRG6Lzames8KCvKg5NGAyM76J2VQa8hALR/7I/cTC1DPHyNr1QKqXa7HLU
	 SrGlJn8BODneAZeIJyLA5PJ4MElxrmgIEV+TgKtxihkpb3WpgUQ5YHe29hjM2XB3TPjOS
	 +6iHL62LV5jdJpaA4zuHkFEWPsEWTSgxuMpx375H6via9vaWe2DCV/hYJw7TqPwfYEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709663;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RQl3hqohQ/Z/sRPHduciY8J4ZvVSVl35Zc9E3tyencc=;
	b=tnn2jY/f0EJDlXh3LhV4SHoc56zW7qQzfTlfkD8Dcmj/xo+I9n3OqmbvqnIYdO+Q+xRA
	 0l0uLxphkqFZ9gkgdDbSNAnj2y22hsL3TTWKc3k0VhYyxuZSaTLuzSgrXA1Kxbi1x02y5
	 d0sj0JXAOhw87MvrTJFP7PFnUX336ySZ2obTonNKfdAwJ6Gxg4uYZwFXg68Hbe5gCKIxe
	 7oOTJjRkvH08LCOTbYmRcwMH1NkW69GLURc6VXIMlr7uT8N/Vj5NniPfGmDlwo4VRWSb6
	 Mns/PBWP63YqueYYNR/Bd2WLxSI36SPf/fK/83onFdR5i7vv1XIX5+hT+XnIagNqLLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zUaLjWZJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5790606D801
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 12:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5790606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zUaLjWZJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLqMoftDiHe9hhKXBkiw2Zj2sJ3YLpLLwesTDU53O+4H3auu7u+SfFzCJVwB+UgwWZVZdNGOUW/tllyhXlL11cQtpLS6embd4ISbj+7T66h5J/O1rW+AwmFBZ1DF2uosSb4xRnVV3/dchvt+VpS8iKwP4sxaCbw+90s2TPwJbHN6MIA68sIBy0hmUdCieH2LStJygiW7vel9LM834ncibiryfkWB2moq7MPJKy/EKEDe3NagHARnjxDZsFiKnVJ5nW3WC03qG4Sdm3Pr46IdCr6vWUvrPzVr6U+xydVkeFn/BguDpvhe6fghsgxZ5h/Uf19npq23KivUy3RgYLlg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQl3hqohQ/Z/sRPHduciY8J4ZvVSVl35Zc9E3tyencc=;
 b=vjOPkJJpIL/n14ztZ8Iwz/5KTpaO8PDHofvIh6zqdcEk4EhVqYrM/5nSNw9p3ks0R18JeOEU+87iCBfoIHjQe7YOaFaXQey+zGiIn8uvoYAxHHKNG/biwQg+xKh/3bwmnC4jsbikVHai7AeTAY86PG7+TOK5hllXaswktg90/wF3ACAyPSnPXj2nPxWMgykCu4reEwrzEhz1LNXUkAuLHWQy0k+1wFQXQzbvtx97FWXvHv+Ycuq1yiMsfFXJfgDfsIr28WJxhZDPYrTz7tEFXHUPS/4cJJihJolKDbG5sxSXvEkdpCr/OXsygo58QK0MaDxTcFkHUXbmyzUl2JwppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQl3hqohQ/Z/sRPHduciY8J4ZvVSVl35Zc9E3tyencc=;
 b=zUaLjWZJpHDTa4QL5CUyKxl/oyOyRggGTnRCqKTC7RFf7lh5Ua4aiFSupk///E8PCe66cRN1eV8qPG9/7UZZBaM4Yzrd82T2u2PYB04bO5cvJeODyBrjhRFGNIO+VA5TZFzykpt4efucj77Y6aq5Pk6sElgwRZxVn2SU9qsLY1s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 12:40:56 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 12:40:56 +0000
Message-ID: <797e993c-f477-4777-9485-5a9b89aeea7b@amd.com>
Date: Tue, 3 Nov 2026 18:10:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
To: Rob Herring <robh@kernel.org>, netdev-bot+sashiko@kernel.org
Cc: srinivas.neeli@amd.com, nagadheeraj.rottela@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, michal.simek@amd.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, edumazet@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20261016-patches_v2_external-v3-1-e33d3960ca1e@amd.com>
 <179249749105.3135.3116293825083161439@kernel.org>
 <20261021031657.GA3867774-robh@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20261021031657.GA3867774-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::7) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: f33a8ebb-ff59-46d8-9239-08df39a7b46c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|3023799007|10067099003|261102123227099003|11063799006|4143699003|261021121427099003|261026140227099003|261022105027099003|56012099006|261026121527099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	S6oO+0ya1mz+M5Gr6Rjh7OmVSyfrxP+ivbwndFq1FdM/0jEbdWk4bEnzLG4hf8Bo/6DMiIUXVaOBmibcZHa1UWF1rv0fD7PPJ6LeO0B9hbMWr+JvQ+YJ1HQkMuxbsDf39Ty7mMfKV2ryZNGSWhXytzw/z6Fx2BJw4VNvPOmx8FI0DKw+AhVrB551FC0ZuwHXpFMgSEgFVOvki4GrdEmOQVagSqPRml1kEXOLmq9dq4W2PCaHVDlh+VCraIe2nRuL2wuek+n1dPZ08IUD5blURMATLVjbQZ3bkwvhtC/ySdMRYEtYXxVzZt1WvSiJsnit9x7l6a+UijtkePLtlMJXZ2qSOtBw/9wtwMriOmVKf/EdzYH0QbkVlJd8T7jM5vfGcrgrO6zhiVmHPtTyKK0PtrnmZqXoTaaVPXjqYOKv25hi5QrkSmzR6y1L4qJLFiNrA1CPeGCKGC4vT1MKeL/S5bzWoNX3SbWBIYfnYH2jKEnwe3sU+0NlWaTw0+x/Ij7b++pMrTlbA19WD7QcQWYdHzD4r5YxuYqBeMNcWwNSlcAO2MjrRN4RNnY1ZnV9enLEIOcNpQnzRjeYVjdSUfz05KMHCk1R6nYD6D3CEHwdKR2B1UaaGuEGqKZ/I88+qUJd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261102123227099003)(11063799006)(4143699003)(261021121427099003)(261026140227099003)(261022105027099003)(56012099006)(261026121527099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2UvK3NUUWJ0bUF2L0hsTGI1dVR2YkVWcmpvaFJIY2VkSkFPZ0xNai9obHdp?=
 =?utf-8?B?a3diVE9IRWRwV2RnSGRqRkM0bHNQNkxFVTBJMUFxLzBXcHptVXBVcWQ4b09M?=
 =?utf-8?B?OURDSjhXR0pIdktIWTVzYldta0lHOVRENStSS1lqckFTVGZZbzNBb3NSS3U5?=
 =?utf-8?B?ZnRFR2FPR2lMaWdKYVV5ZE9IeVpkZG85eEUzVXcxZWFOSjB0RGlHeVc0MmpC?=
 =?utf-8?B?cmUwR0VyclQ1ck5icHZRWTUxaGVkNnJMSy9TL2lMSGxIOXZ2THdNQ3c5VGlx?=
 =?utf-8?B?M3ptUzgzb0tRZjFlNW5DakxOdjh6UHdMZDNLWWlZOUMzVjRDVmp0cFNzTkhs?=
 =?utf-8?B?aVdrVnlRVE03RmRna09TYTdnQXdQVTVaWkNRTlJZeC9XWnNvVjdoamNiMmxT?=
 =?utf-8?B?ZkMyRlhqZm1TbnJubGZER3BmRFJ3dFovQVRET0REc3RYRUdpSkZKblhpbnM4?=
 =?utf-8?B?Kys2Z29EMStTb3VZd2NTbU1qRWtpZHhZWVZJYmlaUlBGemdsQWdBSnZodUs3?=
 =?utf-8?B?VDhiWHN2SGNBdDM1N3Bwb3FNam1rbE9uZzFYWE5JVURVNnRudEczRmdPbytR?=
 =?utf-8?B?TEkwNnR2QmZvaEI0MFpSeFFwMkRwcTFwM0dQOWtnZzlta1BLTU1zNU8rRmlX?=
 =?utf-8?B?Sm9rcmZDYUU0R2pXMTRndnVHZE1vQ2oxVEpCbFVjV3ZFVkdsVCt4QU5KOU15?=
 =?utf-8?B?eitESjdCT2ozL0V4MUc0UHdQWWhGQkFid3FMRE1OUHBITUJLSG5WSDFRRTdH?=
 =?utf-8?B?MmpOMjVrYTFTWndaaTEzaXQxSi94OTY5YzA1eEh4QTdlM3dwOXdSZmIzbzhX?=
 =?utf-8?B?SjRrU0MwaHJOZit3RGdjMno5YmJVTnlRcGpnZFlPVjBJb2thN2RWUVlUUW9B?=
 =?utf-8?B?Wk54V1RkUUVUSm9JOXZ1WG1NcDBQeTBlT1k2bE1TWDFvRTZISXd1K0NLays2?=
 =?utf-8?B?TFdkYysrbmtQWHNoZHhnSlFhYWFjc25MazRITHZpWTNoemh4UGdycnhiMExp?=
 =?utf-8?B?L2V5K0dkYTdzZmZVUmhyS2lzbGhXM3gvblFSd0lCVy8ydjJlTEttcUhFUlpq?=
 =?utf-8?B?YUI0ejdBY2JLN01udkNSWmovTzN1MDJOU1o5NTVtajFlaEtneEViT0VMM3g1?=
 =?utf-8?B?NVRGL0FFcW1idnNTY2wwRFgwSXU3cmRSZ2plb2ZvczcxRStSOXVLby8zZ2Uy?=
 =?utf-8?B?M2ZvbWNLT3V5RnloOUV5bWgzOVFFb1o4ODQxVGtNWkhmNWxWbVllMFA2OTlL?=
 =?utf-8?B?dHJ5OCtQV3JYQTdKdVYyNG44Y3lYWlNSdW5UN21VZ0lMNytCbjcyNHh5b2Jz?=
 =?utf-8?B?V2QvWmNzYWJUNG9DMk80bjFaelRNRE9nWXMzUHJycG40NC9kN1E1MUt1anNS?=
 =?utf-8?B?anRTcE5uOVZaWXk5V2YwV1BhV0IrZ09pb0owMTdzdWdNdm9icUcwRHFIWk1s?=
 =?utf-8?B?T0daUERwL2RaTmdFdlQyd09QTzVrOFpIYlBqYnZRV2lNNTJCb2dVdWlxN0Zx?=
 =?utf-8?B?dGhrRldybjczcjAyQmhXR3FGZWU3ZXVBaUs4cE9KTEZaTGpXaTg4SHRYNVpN?=
 =?utf-8?B?VGJQUmdDdTUzUnhyV1VXWUgvZnJ6SGRhMTY5QjczcUlzQnpqNWtpOHBLelgz?=
 =?utf-8?B?T0VETXBZdGJhS3hSU3FSQjI5R1pzbWVua3pWaGtZYnl2MTRjN21kL3dhUW14?=
 =?utf-8?B?akhEaG5Tc1hqRkJuMFRaYjMwUkJXb2RKaHgyelZ3TkhYeEFuWnpWOTlHWkNn?=
 =?utf-8?B?NXloSWRhZFpZMmp4L2tUcHhUVzE5aXVWb25WZmhuK2hjUnJpY29XRjNpeUF4?=
 =?utf-8?B?SlEzVnVIdElTMVBDMEhmekVTTExPb0xsTm9USEp1Mzl5V3RNMDJiUFd4VE1i?=
 =?utf-8?B?ZklXd1JQcnFnQjB2ZDgvQnI5M2pTdTllUVdOYnFRb1o0Z1Q4SlF2N0p3bFZN?=
 =?utf-8?B?YTJLUUhoMXk2L05oZ0YvV0tscVdjcWFiNWlMRmtvKzFzUmxoRWVNSFBkOUhu?=
 =?utf-8?B?bk1QV3MvRGp2Z0pFa2wwem1kWEhCYmVoSm1RUFo5ajR5UnFIL1JVQXRUcmtY?=
 =?utf-8?B?bXRmOGJWYmVWMkY2WURyNG11SFJNaGJjeHo0MzhlQ3RGUWpBSkdDajh2cGtS?=
 =?utf-8?B?NnEzcjkrVGxlRjZ0Wm81MHRTRFh3dVRWc1VTZms4dlZRVFhRV3ZUMUc2Qjh1?=
 =?utf-8?B?MGtEYW5Ja1RhVG4xUFJRSDErc1U3UHdQWmVuQUlzWFRiZnpKUzdEeG1MWlVU?=
 =?utf-8?B?bWh6clJZZEVsZDRVREIvYmVkQTVqeGExR3c4UE5nckV5cVo1TGNzSWowVTM1?=
 =?utf-8?Q?qaZTx/cfIfxGauKPUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33a8ebb-ff59-46d8-9239-08df39a7b46c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:40:56.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+/cvT1xtftGoEE49y/PJ3O1lDiWCunU5zxHTs3ong/AWPKpr8Ns1TEG7O73w+v4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

Hi Rob,

On 10/21/2026 8:46 AM, Rob Herring wrote:
> On Tue, Oct 20, 2026 at 11:58:11AM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found more severe
>> issue(s) in other patches of this series. This mail is only an FYI, in case
>> you want to address the nit picks below when you respin.
>>
>> Low priority / nit picks for your consideration:
>>
>> - [Low] In Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-
>>    ethernet-mac.yaml, the ethernet@ node's dma-names (lines 81-96) does…
>> - [Low] Concern: tx-queues-config only enforces a lower bound tied to
>>    xlnx,num-priorities, and the rest of the checking is left to a driver…
>> - [Low] The child compatibles in
>>    Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-…
>>
>> --
>>
>> dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
>>
>> This adds a YAML binding for the Xilinx TSN Endpoint Ethernet MAC IP in
>> its Bridged Endpoint configuration. The wrapper node owns the shared
>> clocks and xlnx,num-priorities. It has two children: an xlnx,tsn-ep-mac
>> endpoint that holds the DMA channels, and an xlnx,tsn-switch three-port
>> switch with its MDIO buses and ports.
>>
>>> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>>> new file mode 100644
>>> index 0000000000000..bca834120b3b1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>>> @@ -0,0 +1,491 @@
>> [ ... ]
>>
>>> +properties:
>>> +  compatible:
>>> +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
>> [ ... ]
>>
>>> +patternProperties:
>>> +  "^ethernet@[0-9a-f]+$":
>>> +    type: object
>>> +    $ref: /schemas/net/ethernet-controller.yaml#
>>> +    unevaluatedProperties: false
>>> +    description:
>>> +      Endpoint MAC sub-node. Provides the host-side data path through the
>>> +      DMA channels described by its dmas / dma-names.
>>> +    properties:
>>> +      compatible:
>>> +        const: xlnx,tsn-ep-mac
>> [Severity: Low]
>> The wrapper compatible is versioned (xlnx,tsn-endpoint-ethernet-mac-3.0).
>> The child compatibles here and on the switch node (xlnx,tsn-switch) are
>> generic and carry no version.
>>
>> writing-bindings.rst asks for specific compatibles, with no device-family
>> names. For sub-blocks of a bigger device, it asks for device-based
>> compatibles.
>>
>> If a later IP revision, or the planned Endpoint-only variant, changes the
>> endpoint or switch register layout, how would these child nodes be told
>> apart? The endpoint driver later in the series matches only on
>> "xlnx,tsn-ep-mac" in xlnx_tsn_ep_of_match.
>>
>> Should the child compatibles be tied to the device or version, the same
>> way the wrapper compatible is?
> It's fine. Being specific is less important given there's a specific
> parent compatible.
>
>> [ ... ]
>>
>>> +      dma-names:
>>> +        minItems: 2
>>> +        maxItems: 16
>>> +        items:
>>> +          pattern: "^(tx|rx)_chan[0-7]$"
>>> +        allOf:
>>> +          - contains:
>>> +              pattern: "^tx_chan[0-7]$"
>>> +          - contains:
>>> +              pattern: "^rx_chan[0-7]$"
>>> +        description: |
>>> +          Names matching the entries in 'dmas', one per DMA channel and in
>>> +          the same order. TX channel names use "tx_chan<N>" and RX channel
>>> +          names use "rx_chan<N>", where N is 0..7. At least one TX and one RX
>>> +          channel are required. Example: "tx_chan0", "tx_chan1", ...,
>>> +          "rx_chan0", "rx_chan1", ....
>> [Severity: Low]
>> The description says the names are "one per DMA channel". The v3
>> changelog says "Cap TX at 8 and RX at 8 channels". Does the schema
>> enforce either of these?
>>
>> Without uniqueItems: true, dt_binding_check appears to accept a 16-entry
>> list of fifteen "tx_chan0" plus one "rx_chan0". It also appears to accept
>> "tx_chan0".."tx_chan7", then "tx_chan0".."tx_chan6", then "rx_chan0".
>>
>> dtschema doesn't add uniqueness to -names properties by itself. For
>> example, renesas,drif.yaml lists "rx", "rx", while renesas,sdhi.yaml sets
>> uniqueItems: true on its clock-names.
>>
>> Could uniqueItems: true be added here? The pattern only allows eight
>> names per direction, so that would also enforce the 8 TX / 8 RX limit.
>>
>> Later in the series, ep_count_dma_channels() rejects duplicate TX and RX
>> names at probe time. So the runtime result is a DT that passes schema
>> validation and then fails probe.
> IIRC, dma-names is the exception here. So yes, you should add
> 'uniqueItems: true'.

   I tried to add uniqueItems: true under dma-names and I observed the below
   error:

       xlnx,tsn-endpoint-ethernet-mac.yaml: patternProperties:^ethernet@...:
       properties:dma-names: Additional properties are not allowed
       ('uniqueItems' was unexpected)
         from schema $id: 
http://devicetree.org/meta-schemas/string-array.yaml#

   As per my understanding the core DT schema already has uniqueItems: true
   for dma-names:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/dma/dma.yaml

   I also tried to reproduce the negative test scenarios reported by
   netdev-bot using:

     make dt_binding_check DT_CHECKER_FLAGS=-m \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml

     With DT_CHECKER_FLAGS=-m I can reproduce the reported errors. 
Without it
     those negative scenarios pass. As per my understanding netdev-bot ran
     without DT_CHECKER_FLAGS, which is why it reported these cases as
     accepted. As all the scenarios are rejected once DT_CHECKER_FLAGS is
     passed, I am ignoring the warning and keeping the binding unchanged.
>
>> [ ... ]
>>
>>> +        patternProperties:
>>> +          "^queue[0-7]$":
>>> +            type: object
>>> +            additionalProperties: false
>> [ ... ]
>>
>>> +        required:
>>> +          - queue0
>>> +          - queue1
>> [ ... ]
>>
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        xlnx,num-priorities:
>>> +          const: 3
>>> +    then:
>>> +      patternProperties:
>>> +        "^ethernet@[0-9a-f]+$":
>>> +          properties:
>>> +            tx-queues-config:
>>> +              required:
>>> +                - queue0
>>> +                - queue1
>>> +                - queue2
>> [Severity: Low]
>> With xlnx,num-priorities = <2>, can a tx-queues-config that contains
>> queue0 through queue7 still pass dt_binding_check?
>>
>> The ^queue[0-7]$ pattern accepts every index from 0 to 7. The if/then
>> blocks for num-priorities 3..8 only add entries to required. So the
>> schema has a lower bound tied to xlnx,num-priorities, but no upper bound.
>>
>> Later in the series, ep_parse_tx_queue_config() rejects queueN with
>> N >= num_tx_queues at probe time, so only schema validation is affected.
>>
>> Could each if/then block also set queueK: false for K >= N, so the
>> schema rejects these nodes too?
Understood. I will address the upper bound check in the next version.

Thanks
Neeli Srinivas

pw-bot: cr

> Shrug. Sounds too complicated.
>
> Rob

