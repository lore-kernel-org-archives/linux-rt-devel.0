Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021119.outbound.protection.outlook.com [40.93.194.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38A2C326B
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956209; cv=fail; b=GLhCXFCP36TJGCQwn3GUbDdN0sMHQ8LzpBvNd4aOa4nrHvV+8rmmKZDNau843wIv63fq7eZigqtKIBQEkA1rpOuTbdHWvhV+X+nDWgYIgc/wuFEefzgXkCKkkfjRoHHwD4CcBg3iy09aW9db8I2NDebatXX1JGQ6/J4SKwOnewg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956209; c=relaxed/simple;
	bh=B0LPK6898dnAp7ZIx9bYjulkMxW7ygnMcgX/aw98Txw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPwOmMEEoAZkVg1IKGyE+vpAFL2fUjVJNjrSGSheI+SAmJUiPOCqDP47t2rcdjiyBbZmUmDWaZZt+ok2Bd9Vi5o7HyeEMJ1TPkaUVQRuTMrJuIDnmlu7RBBO9WcVBWCFy4r9OhlAkKma4v/CjSP/0Qnb81NVOAJ/T+vpUe2K7FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hQFCC6fw; arc=fail smtp.client-ip=40.93.194.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hQFCC6fw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARe6C8P6GxObfG2hDqY5yb8pZAfxe+BcJ0olkn2ugyHUT40/FvnsgqbOmoWV8xPGpPp0M3VRb50NAA+ne5mM56uLXf1RDFcUPkgI4+Y6CCsed4PYkautvlKint2NDGNYTkxEt/6OsT6MPJjHxsSwFbpuJvdmpqtVdFeOdZIF4MOsAz0Ah4kxCuKNTq15uNQA+caW/smc5OF5krkvyZnwhsIdSRyN0gsPwkuo7GrrDZEf8yIuJ3Z8g34g2iVYsOvt8YDD1GnMTi/n4x41udA7LMqjHPrEXSqUenOO5SoZ5/u0hN7pyFOHnpBdGO9U2hyfaNA+M7nCeYQdlEFRPrjVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MwjJPFo8ndMvw4+H9z/imFCy9HLMyRqi4MtXsvPdbs=;
 b=QfqqJWTaR250QuKDu5mrUhAJDA/Il/lCDjeA1rD2GuyjD/6dF7dKQXxaTYCqHln1w0mQzEW9VwqCldFTecxIZyUdG3kBpIVc9fZO857/sCR2kbl1qrupyCqN0BTslVGfxbmXzsrDV/WOBS2enDzV4e0m8iPURNElFFrH/QlIQkRdBkKIkp0xJ9kQKpF0cCrVLqHZPnV77/VPerUP5FC5wNYQEoVd+WXujKLex4jn89190W6ISY3Jm29LYWz2gS5+/M70VDlbBEA9Nqm2nMIy+oVATTv0NVZD+4jc9kuf+3ae8Lt0dXoy0KFih5zt4WD1wx2/33jHsB7JcIBok41EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MwjJPFo8ndMvw4+H9z/imFCy9HLMyRqi4MtXsvPdbs=;
 b=hQFCC6fwBbPZNesv7iHCbmdsgC07oHDagVLdju1scGn8612wgJpMeHzXqtap5jfKtpSKrDcrpiZdFd+hsO3WD/prXCOk57CsOxkXrhgzb3jt1+mkHSdbsqBtTrFXQlmbwvYeGjM1GoeIimarCkVhunMKFjNX6V5aOBStlh7r13M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB7902.prod.exchangelabs.com (2603:10b6:806:34c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Wed, 21 Jan 2026 00:43:23 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 00:43:23 +0000
Message-ID: <2a18acfc-7de5-4ff8-bcce-14a3212cef75@os.amperecomputing.com>
Date: Tue, 20 Jan 2026 16:43:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
 akpm@linux-oundation.org, david@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, dev.jain@arm.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck> <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <5a5c78a4-0b07-4337-8b31-a2cdce1834ea@os.amperecomputing.com>
 <aXAJRx5JtTenw1Ou@e129823.arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aXAJRx5JtTenw1Ou@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a6dec1-f777-4fab-16f8-08de588614d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDAyWGwycldYYTAxTGZubktNWTBFTEVieGRpV1Nwd3QwQ3pqYXg4OE1YWklN?=
 =?utf-8?B?bFVBUldDSWRuVys0MUdmS0N4L04xb0FsRzNSQ3JhcEpwZWRidlZmK0poMzB4?=
 =?utf-8?B?cGlXSXhKZ0I2dlZFOUQ5RmNlSWpnbVdoTEdEK1JoMzdjK0xZL283YWN4bk9F?=
 =?utf-8?B?TVJPMExnV1ZnYzV6cFJKckNGVG5sdVRyMlFldTlDTmR4TmQ0Q3dZN1dVd0J5?=
 =?utf-8?B?SkVCbm9OWk9NekFDSG90Nm5GelZyN2lndjhWL05LYStiQUozMnFhOVpiYmxR?=
 =?utf-8?B?YUVWc3VXa2RGekcvVTFibmxtZlRjZ0dNNDdPOUkrWnRXZm1uRlFmM3ZUUnow?=
 =?utf-8?B?eVBER3lGSEJvS0dvajlvVWdMOENQVm96S3dWTlBBc1RNWEJIR3BSMnNuUUFT?=
 =?utf-8?B?VmVJdFpRcnBIc3FOcXNUUkllbEhoTllmWFVoejVRR3I3RFhvQU5hd1hGckYw?=
 =?utf-8?B?T1phbnhTRGtQUm5QYzh5WWtBQ2JMQkNuUTY3TjF0bVNRZEwyYkVjb3NPNkJt?=
 =?utf-8?B?TUdVZC9GMGRSSmNEMzhrdlNpUHkzY0FubEF1dHBTaGxROTJzOURiVjlhcGVS?=
 =?utf-8?B?YU51VlBWOEd1ODlVMDVQcDVqM2Z5WWxFWDBtdnIzcjZIQXZwVU9zMC8ydzhz?=
 =?utf-8?B?OHQ5R1FLcElEOEZ0R2VsSDNnOXVPdGhFSEtxL3R0WlBkTEVTRklxcmdjdU9x?=
 =?utf-8?B?SzJXQ0t6TWw4STlqZEJBT1ZoMjlWdjQvQWRvZ2NBM1V0bzJIV3o3TktKYy9U?=
 =?utf-8?B?R1lZN1R5Z0w1bDJLZVNid0FRWmk3eDgwOG5wTERRd0VFSXJhczB5ZFNCbFpu?=
 =?utf-8?B?dzdzTE1nNGw2R3IwSUU0cTNJRnBGSEt4d1NBa3dObXZxMXBOTE84TUVkWlN4?=
 =?utf-8?B?S056K1h4a05mK0J6TkYrbXErM3Z5aXcwU2s4Z1RoQW5KbW1jUVBsQmx5VkNS?=
 =?utf-8?B?WjlMcE1PNkcwY3JZdFRuLzNKRi93ZkdhWlo0NTJibS9VVkJTby85Ly9iemFU?=
 =?utf-8?B?am1yOXRUSFpXNGVlYmtxaXgyeVU4N2hlL3ZEYVB1R2x5dWprSTQwZUpoSmJq?=
 =?utf-8?B?cXlYcGw4TEh3cTkxTUc0TVE4N3VDcURzMS9BNkJ3ZEVrRGpwVDljRW1yVzRi?=
 =?utf-8?B?K3FObVZUcWlXMjJ5VkZCQ3JyM1lXeEVhSG5BODl5b2RMd0FrK05PQ2pPa2ZI?=
 =?utf-8?B?N01maitSdXYyNTVZN0dSSC9PSHVTKzFxNzR6endpd1Q1aHpOVnFHSXVYdUtj?=
 =?utf-8?B?U0d3bVM1Q2JnQnM5d0JyOUFlS0RyeHVKSGZEcGg4RnBZZm1yMnRGL3N4Z2tZ?=
 =?utf-8?B?eG54VzUwdHJsRmFGTWt3K0cvMG1zbEpQTGYwNW00azdwSVVEd0tuMVI3MG5B?=
 =?utf-8?B?MGkrZmRMeWRDS25CMW0zTGY3bnhkR3BZNFZucHk0WGFVMXlTUXV4SEU5enoy?=
 =?utf-8?B?cmhTUHowT2FwREkrTG12L2lRMjZla0dJTUkwSzZvaUdmdGpuNVVLQnphL0F3?=
 =?utf-8?B?SkRhWGh1d0NWWDM5S0NQa3JxcG1iKzlSK0s3bCt1UDU1LzAvd0hJWWlyaHdG?=
 =?utf-8?B?REY2RERmeWpBV055Rzd1ZzdnQ0d6Y2Zsc2lvYWRqMTN0ZlJobW5qcVBhbVI1?=
 =?utf-8?B?WGdXdFVxU1FOS0dZcjdPRDlkVXByUGpvczJvdUZ0cUtVYnF4enRsWDZxUmtW?=
 =?utf-8?B?UDdaNUxLWVlLVkQycWwxcElYcCt4NURNMy9LdlJZRjBCZ3FqZkVOVUphYytD?=
 =?utf-8?B?TVp4Y0ZINHpnRFVxOFlFaEt1Y3NDOW1XeUdPK2w3aDM3Y0NnU2haZWplRkR2?=
 =?utf-8?B?WnRTRlhtT1QwbWdkdjJNbFZsMkpDa1dIL1hDazZJSTJVcGdoTDBkSmhtUkdt?=
 =?utf-8?B?MGhkM0pSTTZxRXhUVmlFVVNkQ1ZZdHlpR2pCTzFuWGlwQjhwOWJaTUNvZGNU?=
 =?utf-8?B?azhyTGVlU2FKd1hmY1RKQ2NiOS9KNnNzNUpteThIZHRtMm5OUGZRYUg2V3lu?=
 =?utf-8?B?TVJOYWJLczRZNitWSjBaSEdkdDFGSjNNOVpiaGh4VkY4RmNGVEtKeG5STUpM?=
 =?utf-8?B?Z08zUjV6TEltK1E1eHNGcmNWcEIyZlpDWDhCUnNBc1VQVkpuZ0lrOGJnTG5V?=
 =?utf-8?Q?Cajk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RsRWhtNUFRZDhzNnAwQ2dWU0dKRXk3NjZnKzcyUFpOcEVlMFBIWXBHdW5s?=
 =?utf-8?B?ZzVhcFQ2MGFvQmlaSU9VYU9paE40RDk1MUhMcUJKNDRpYmpzZGNWZWJoVk9Y?=
 =?utf-8?B?VzR0RDVXNGNTQUkwanpDV09tV3lzOEt1eWoybnJldXo5TEIyYS9Yd0lEKzdv?=
 =?utf-8?B?ejk4UGpjM1g4RSs0ZXp2R1g4R1BSSm1CK1lWUGJDMnJwcmVNem5RRktrVDBt?=
 =?utf-8?B?TzdSVUgwalpWa3lXdTdjU0l0ay9QdjZQSWZlak03R3E3RTBCZkZ4bHZWZzhj?=
 =?utf-8?B?WERuakZ0NUtjT3VxN21pSXA5Q3JRSzdydlJ1MHpTZFd3N1ljQ293WmtEdXZk?=
 =?utf-8?B?UHF3OXhWekxVYmF6d2lDZVJ6N1VMZnhDd3QvRlVvQlhpSWwrSE9zdTNQaEp2?=
 =?utf-8?B?MEFlOXRZbVVzSkZ6YzN5d1dML2FWbHdnWkNpZ015cmRKOERwd3lnVFhGcjZM?=
 =?utf-8?B?bXJwczFFRVd1ZHkzRzBZc0JPbExPYnNtaGV2ZVFHM05IdlZnbldkN3JuSXkz?=
 =?utf-8?B?YWJ5NENHOE5kWG1zSEJNVS9RamozeWVvZ1ZUcTRUb2t3OVJrTGovRGhRMm13?=
 =?utf-8?B?ZGVCczhhakNrWU9TNDZzOXpjUEFFZ292R2VWQjIrNWxzV3ZPcHFmakV1U2g1?=
 =?utf-8?B?YW16QktIV09BUGxnVmpvak1sRFowYmlRd0IyNXpIc2lCcEt6ZmszWGFuU09m?=
 =?utf-8?B?djF3UFlJajZUOHpiTUx2aEtZREY3OU1QSFRCTjQ1UmJheUtGYzJCNnpnRVdp?=
 =?utf-8?B?dHltQXpFVW05Njl5WCtzL2NEeHNTTDVWd2N6ZktRQTJyZnhudFN5K3Awamlj?=
 =?utf-8?B?cEtSVUM4NXJ5dWpDSnVqcjNjVVF5ZkFWUmdmRHM2SzVTODMzUkd5V3dGKzVu?=
 =?utf-8?B?V0dvWDlidjNCMkdkZDNCQ3Q1S2ZlZXI4Q0kwQmQ5TXdCUmtmcDhtMmxNMFN0?=
 =?utf-8?B?NHcxNVBaS2wxZXVkRU5WczZVK3ZjL3JtdWpRQkNqWlp0dmxJb2VRRWtyMVcv?=
 =?utf-8?B?eWI2dEl2L2RLdHBXNkFEUlo3M1FLTjFaUnEzNFRKcmN3MDN2SHAzVFRodTVE?=
 =?utf-8?B?aTZaWTZSNW1QbFhEQ1FUSkxvcTc3R1paUEp1Skk5OTdNcnN5WXJseGMvd3Ju?=
 =?utf-8?B?b09GcjcvdGx0eDhsZ3FEMHNsN3ZrMzdxUy9ucHBXYUxaaVh5NWRDQmdVRklT?=
 =?utf-8?B?SGEzRUt6Umo5d2QyOERFN05sNnFHMXR4Z3ROOEhRS3NrdlU2K0JpdW9BdFh5?=
 =?utf-8?B?YnNIUFh2MVNlRDN0SzNqR1RxeXRRK3podThSUlhVRVNkdEwzcEV2UmZtMGpW?=
 =?utf-8?B?am13S3p6L05TbUxKN1N5ZWJNL2hHRlU3QStUUjRySVBGZzduL3l2eGRLWmlo?=
 =?utf-8?B?NCtUeFAxTGxab3JCazlXVElJRVdtTHFJVjVpeFQ4REUxcEpRRUFHQ0cxTzBi?=
 =?utf-8?B?S0RzM1RSemZ6eFpFU3d4L1lVcHlKTjdIdkdxbVc4T2FZUm1qc1V3RUJRUHU2?=
 =?utf-8?B?NW9GblkxcURUWmpYNXBXOVJmUnZEQ0FlN1RQSU1nQWwvSUI2NmFHK0NKRXh5?=
 =?utf-8?B?T05qaEV2aTRSenhuYmkzM1N4N3Y1ejFyT3N6c09KQUkzNWlZZDk3WXhvVWlD?=
 =?utf-8?B?TlhIZGEvK3NwSlorUUpNUnFxNDYxam5oQkZ0TkxXL0lpcHFhZGtqeCtWNFNu?=
 =?utf-8?B?OStQU25PM3NreVlLcUVwUGpHU05hcVdDd1FHQW8yT0JCWE80SmdvaENJbjZF?=
 =?utf-8?B?WFBlQURveGkwQWg5ZEIxNXpLclU3YXFqY24zSWwyVXlsOFVjcEdHMVFScTlB?=
 =?utf-8?B?d0xCYTlBWTVmYS9iclM0eFo1YWJybUxlVFFJUXZqUFVPQWFyTHlHd3g3Nklx?=
 =?utf-8?B?NS9Qdll4OHZmQW1qVWYyajFtVElLOFNEWldWYjNhaG5HZ3JBT2xtT1RhQjdK?=
 =?utf-8?B?c1BLWC9lZUZEbENrNlZhc2x6M3grMTEvaEpHZ2g3MUhzKzhpQTNTVmV5Tnlh?=
 =?utf-8?B?c01TclVTd09ZelNWbGZPcFEyWCtMbXIrNHVscHczU2RFN3N6emFYZFRSN3lu?=
 =?utf-8?B?bzlFUUJJcFpKUWNJeTYrNnBUb0pUK09SVW1RRkVnMDZzRkJqY0NVbzljSTRl?=
 =?utf-8?B?NlhLSDE4UW5oNldaZHpSNkNWTWJzSlVxZHg4VG5KLy9mMlBuZVpXeGlJRHh6?=
 =?utf-8?B?M2ZzMzNRVW44ZVVaRU5QTnduR2lib0pvQS94QjVJQTRKYUJRRnMrV0RmV240?=
 =?utf-8?B?RkRJTkUzTG95amFPeHliU0tIUjNrUFB1MndjQXRLWlBaVHpTdi8yNkRmclBk?=
 =?utf-8?B?SkhJTE1VTEJXekE2VHNzY1I5M2hScnJ4cnpwVmhzWGFuK2hTRmFSM3JVNG1L?=
 =?utf-8?Q?AnuQvBthRyNPyDlQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a6dec1-f777-4fab-16f8-08de588614d6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 00:43:23.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi2O+vEQgPZvnevwtgq3vaWJIT+N4FxyOu59agIjdxGKefxMWfOLrWbaUNXpAkba3hTtVrkQo+/Guuth1REl+o2JsoYWi1V6DaYT2MmlvIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7902



On 1/20/26 3:01 PM, Yeoreum Yun wrote:
> Hi Yang,
>>
>> On 1/20/26 1:29 AM, Yeoreum Yun wrote:
>>> Hi Ryan
>>>> On 19/01/2026 21:24, Yeoreum Yun wrote:
>>>>> Hi Will,
>>>>>
>>>>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
>>>>>>> +static int __init linear_map_prealloc_split_pgtables(void)
>>>>>>> +{
>>>>>>> +	int ret, i;
>>>>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>>>>>>> +	unsigned long lend = PAGE_END;
>>>>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
>>>>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
>>>>>>> +
>>>>>>> +	const struct mm_walk_ops collect_to_split_ops = {
>>>>>>> +		.pud_entry	= collect_to_split_pud_entry,
>>>>>>> +		.pmd_entry	= collect_to_split_pmd_entry
>>>>>>> +	};
>>>>>> Why do we need to rewalk the page-table here instead of collating the
>>>>>> number of block mappings we put down when creating the linear map in
>>>>>> the first place?
>>>> That's a good point; perhaps we can reuse the counters that this series introduces?
>>>>
>>>> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
>> Yeah, good point. It seems feasible to me. The patch can count how many
>> PUD/CONT_PMD/PMD mappings, we can calculate how many page table pages need
>> to be allocated based on those counters.
>>
>>>>> First, linear alias of the [_text, __init_begin) is not a target for
>>>>> the split and it also seems strange to me to add code inside alloc_init_XXX()
>>>>> that both checks an address range and counts to get the number of block mappings.
>> IIUC, it should be not that hard to exclude kernel mappings. We know
>> kernel_start and kernel_end, so you should be able to maintain a set of
>> counters for kernel, then minus them when you do the calculation for how
>> many page table pages need to be allocated.
> As you said, this is not difficult. However, what I meant was that
> this collection would be done in alloc_init_XXX(), and in that case,
> collecting the number of block mappings for the range
> [kernel_start, kernel_end) and adding conditional logic in
> alloc_init_XXX() seems a bit odd.
> That said, for potential future use cases involving splitting specific ranges,
> I don’t think having this kind of collection is necessarily a bad idea.

I'm not sure whether we are on the same page or not. IIUC the point is 
collecting the counts of PUD/CONT_PMD/PMD by re-walking page table is 
sub optimal and unnecessary for this usecase (repainting linear 
mapping). We can simply know the counts at linear mapping creation time.

I don't mean it is a bad idea for your future projects if it is necessary.

Thanks,
Yang

>
>>>>> Second, for a future feature,
>>>>> I hope to add some code to split "specfic" area to be spilt e.x)
>>>>> to set a specific pkey for specific area.
>>>> Could you give more detail on this? My working assumption is that either the
>>>> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
>>>> linear map. If it does, we already have logic to split parts of the linear map
>>>> when needed.
>>> This is not for a linear mapping case. but for a "kernel text area".
>>> As a draft, I want to mark some of kernel code can executable
>>> both kernel and eBPF program.
>>> (I'm trying to make eBPF program non-executable kernel code directly
>>> with POE feature).
>>> For this "executable area" both of kernel and eBPF program
>>> -- typical example is exception entry, It need to split that specific
>>> range and mark them with special POE index.
>> IIUC, you want to change POE attributes for some kernel area (mainly in
>> vmalloc address space). It sounds like you can do something like
>> set_memory_rox(), but just split vmalloc address mapping instead of linear
>> mapping. Or you need preallocate page table pages in this case? Anyway we
>> can have more simple way to count block mappings for splitting linear
>> mapping, it seems not necessary to re-walk page table again IMHO.
> As I said, it isn't not only vmalloc address mapping but also
> "kimage" mapping too.
> In this case, it need to be split to set the specific code area
> with specific POE index.
>
> The preallocate page is for spliting via "stop_machine()"
> since page table allocation with GFP_ATOMIC couldn't be in case of
> PREEMPT_RT in stop_machine().
>
> Also, the spliting text-code area to set specific POE index would be
> done via stop_machine() so, the collection is required.
>
>>>>> In this case, it's useful to rewalk the page-table with the specific
>>>>> range to get the number of block mapping.
>>>>>
>>>>>>> +	split_pgtables_idx = 0;
>>>>>>> +	split_pgtables_count = 0;
>>>>>>> +
>>>>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>>>>>>> +						    &collect_to_split_ops,
>>>>>>> +						    NULL, NULL);
>>>>>>> +	if (!ret)
>>>>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
>>>>>>> +							    &collect_to_split_ops,
>>>>>>> +							    NULL, NULL);
>>>>>>> +	if (ret || !split_pgtables_count)
>>>>>>> +		goto error;
>>>>>>> +
>>>>>>> +	ret = -ENOMEM;
>>>>>>> +
>>>>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
>>>>>>> +				  GFP_KERNEL | __GFP_ZERO);
>>>>>>> +	if (!split_pgtables)
>>>>>>> +		goto error;
>>>>>>> +
>>>>>>> +	for (i = 0; i < split_pgtables_count; i++) {
>>>>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
>>>>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>>>>>> +		if (!split_pgtables[i])
>>>>>>> +			goto error;
>>>>>> This looks potentially expensive on the boot path and only gets worse as
>>>>>> the amount of memory grows. Maybe we should predicate this preallocation
>>>>>> on preempt-rt?
>>>>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
>>>> I guess I'm missing something obvious but I don't understand the problem here...
>>>> We are only deferring the allocation of all these pgtables, so the cost is
>>>> neutral surely? Had we correctly guessed that the system doesn't support BBML2
>>>> earlier, we would have had to allocate all these pgtables earlier.
>>>>
>>>> Another way to look at it is that we are still allocating the same number of
>>>> pgtables in the existing fallback path, it's just that we are doing it inside
>>>> the stop_machine().
>>>>
>>>> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
>>>> with significantly less testing...
>>> IIUC, Will's mention is additional memory allocation for
>>> "split_pgtables" where saved "pre-allocate" page tables.
>>> As the memory increase, definitely this size would increase the cost.
>>>
>>> And this cost need not to burden for !PREEMPT_RT since
>>> it can use memory allocation in stop_machine() with GFP_ATOMIC.
>>>
>>> But I also agree in the aspect that if that cost not much of huge,
>>> It's also convincing and additionally, as I mentioned in another thread,
>>> It would be good not to give a hallucination GFP_ATOMIC is fine for
>>> everywhere even in the PREEMPT_RT.
>>>
>>> --
>>> Sincerely,
>>> Yeoreum Yun
> --
> Sincerely,
> Yeoreum Yun

