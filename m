Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EF48381D
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045181; cv=fail; b=LZCYvg4yB25IhenkxTSRRdcdTzBDWZ7PJ4qrccIecDK5IKlcIEzCkXNFz0yBjeI2CrunQD9/wxoK+RiR9JvPpMYjCBN87SfDFx8k9ymwL5SklNpkCT968qrla8YMLySlt8Rt9gJW5g60bCKTgWSH3CZnXGWZLIU5uq61ilZzVNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045181; c=relaxed/simple;
	bh=DfKLnAEG1qwhEUcLoBKX9vVjI2iH4f8oLojVzAgp4ps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+HRbjLNrLNbB7O19s8hHYEI7YzFPs0f0UIbQeBtaPYYzJmveEP0EDlyl+6OugyiB4ouMMl0cZkv6s9j/ejJ+XK5r42OKtH0ejXSJjlq0VGnISsApVnh5HEJ5f2y85nch506S2Dou1tyn12CF7rtl174ui5Rex459f1oYWWSEJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=Rdk4dcte; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="Rdk4dcte"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwEbgQbxT7+bZ6w9qwOfV8dmdDLK+N5z60h2vYqpcuYoEaG3uoc0OGiPMdP2WtfZ0jq43/vJy/WluKrby3N37Rdz0tTTkuiIYHq6FdreRC51JHsg0X2/QvP674XEByD/B6yNNev0XFtsJObJxfUzMmX5ykk31sV5UUmdw/Z320z6Ig+GYS2X9SGe7rP8Sbk4vRXupyFRINanQtUgpd3+VHoDSpEYQFlTGke3+n6EcvPCcvT+ipheIKG+OTFfqIJ/WESB7tXuLRbBLRogb4eAIiVXvPS+dOn5fVYcUtc+5N7anyO7/jL086ajMjiah1SOzUNL/Vm6/Cw8OOI+5nCKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kypIIY0Pf/NvXii8gjjYAnkU9fmco5no7kyNCLCb4c0=;
 b=RUobxUyvr1rl/lib3lfqPeU922Q4gebLIR9CH9yK8LvRaTISs+ThRMZOUdEAd3/J9d5GfoKQEppamItIf4cb3Reob6RmASqLZsVn96wFsqpIRSHeC2EIrTCfZxh6Sn4+Ssftw5aS8oVvOJMLoZsxeOW3HU78lEdS0KHX7kukiUI/ik/DiRiL/vwH/Wtujk3AYI1v81MmKLh0AzMx1QvwwnFreywThaozItbeyZcck0ppVAN78ugDO4zylEfcyMOQRirgUTv7trCAlyGy1LsOxGIg8BJryU1ws+RX2qCH7dRnUerVt6fWT+V9ksGqzYNOadAsXXlMeoHGE0TXJpmP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kypIIY0Pf/NvXii8gjjYAnkU9fmco5no7kyNCLCb4c0=;
 b=Rdk4dcteSpZ18j25MV3vyb+vPZojcYLOLFNNG7z6TyD0A5iKNbKp64+4x+vf+z9WZdiDITtqTOGKIB6il/1YAK5pASF6ugCNEFHC/66ZZADutmzQY2eVbpvVqX/nCenPZzJr9WLxXw00LXgbBU2t/vZ8e7vIxFEbDy4EixKUrYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by PA1PR09MB7405.eurprd09.prod.outlook.com
 (2603:10a6:102:466::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:19:29 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 06:19:29 +0000
Message-ID: <46eaa0f0-ff72-4a72-91c8-b610be2d893a@mobileye.com>
Date: Thu, 15 Oct 2026 09:19:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jessica Liu <liu.xuemei1@zte.com.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
 <20261013152727.2cUDX3l0@linutronix.de>
 <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
 <20261014105312.xNkvgkGg@linutronix.de>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261014105312.xNkvgkGg@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|PA1PR09MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e721e96-fd1f-44da-439e-08df2a8444fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lIWrgO8OHdZe2TprQMgyzBECC6pNvM5tQHwWz4Tp4R8kqPRZtwZHiI1o7XTZp9K+Eom5gqDdHWRIlNHvKTeIPv5gifyVb/PD5nItFp0/xa6kS7x9jKeIJh774vFPMD54sx4SByn1uxnFAaEDXR+c6vpB398Y9/MWmeujvZk42dCz8CGDoA/CAYdjzTuonwEZNNRb8ft8RFbggPe4OOpGvyg04E98lR4PGO3rASz4lDYDajf/Kig+9MzkBP45sba8OmwYb892wLKysZqsFvVSAJ+fb6oO+zqN9J2/cWRrVx1I9L+H0M0SkPh9GYWEDU6tLUf1wuFSFx00holZRRJTng1ya0fxhRLDLNFQIJOjWFCC0JW2Ink2nXEMNEMUQGre8xk5Z7kufHk/S2L36IuuG6/d1i+UDkEa+5FmZ7NXGxkVl1rIrLEu18SZi5YyFNMd+H4GZh+L1tBNHM7wkh03nZa+RPUPkUXf1CfWTBB9lYd9JnlwjSOt9soi7AHzg4nKl+rfvo8jKadslhHAn1vBTPtsVnbalBJvYk3qo4L/54T/Wk9CfTxsdlELGu3nm1h3+/qTZi92gJ/kNimVtqhrtS9LsMwAgjo0cqn3S/7WfnFcY19qUr4kOWYU0SrNRm+3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0FvUytjdlRXeG9iQjJPZm1SelYyZU1SZHE2VU42ZDRRNTRYZEJ1YlpJMGpK?=
 =?utf-8?B?eUFBQXlyR0I4aWYyS2NNL3FSQVhYWDFJTnExTXhYelkvV0t4QmNFd2VHeS9F?=
 =?utf-8?B?NFZad3pWUnp0bXk1ekZqR0kvL2RHQU81b3hXT2hteXVTek5lczlvWEo1bWtp?=
 =?utf-8?B?Q01PTnhIYlkzQ0QwOEZHMDJuQWk4eVYrai9xcmRPQ1RoMmhXWjZTazFCSVgx?=
 =?utf-8?B?VUJ1Ty8rNXp0cHNNa0JEYXVCUFlxenFJK09lRDB0TVRlVnNnNXZEWFdWMXVJ?=
 =?utf-8?B?MVZUbWdkVWxJcllBa0RyK2RwbnBjUlBZZGk5dVZEblJuVWw1WmtPK3dXUWhI?=
 =?utf-8?B?M0REZlppMStqQUx1R2VyU0pCS0wveWVVd2hVS1pNWTlld0tJcktwM3lRbFVV?=
 =?utf-8?B?WklKelZVSHZrVnJqaE1McGxGWEVvZ3pGUjVuTklrL2JNeXYrdXJZZlpZY29X?=
 =?utf-8?B?bGVxUVYvdHdyQzhtRTUrWmRlNVR1bDhnVmM4Z1pPVklkeFFzOXJVMGxzb2RM?=
 =?utf-8?B?aHR5TkpEbjRaYjJkdTBXakpvd0x3dkQvczFuK2dhK1l5dVFndXAwdlFDNDBZ?=
 =?utf-8?B?OTFiY0xCdWx3S0MwakZlaGtKOEhoclBGV3NPMkNaeWdxM3Rrc2RjZ2JkREIz?=
 =?utf-8?B?WHBJVndyeldESmtnWU1JTFlKNmdzTzdWZ0NSbXFwcnBXSHBIZmVONERtekMy?=
 =?utf-8?B?SllCWWZWeGIzMzl4bnYwTlRhZnZZckcyTTBtLzBpSmp4YVFPdVdYbEdxd1kv?=
 =?utf-8?B?UE9pbnUyMHMwQjUrYXpSSW11cHAramhOMmdDUDdQbW5lakhwMFZqMlo4VlZN?=
 =?utf-8?B?cXYwNytKcWpnTTF6dVlxWTVTdUFQbkxkR0svMERtZUcvSjFuMnVFblVkZ0Q5?=
 =?utf-8?B?Mng5NFRlS0k5UWR0MnhIbVkxK3RGTW81SmhJZ3V4QmJqeG50SHpFL3R2Ulkx?=
 =?utf-8?B?bnloK2JrQ2NZdWgrcjZsVktpODBTTFQ3TnR0Tk16Zmt3c3JjT3NvWVRDTmds?=
 =?utf-8?B?Wlg2dWcxN2tGSXRUdVRkOVZkeWlxM0FPTWw4QTNGZ256VGZUdlk2ajF5U1hG?=
 =?utf-8?B?MTZVVnUrLzBaK0xMNDlWbkJGS0dSdmdxbHhpdUJHWUFRY2ZUQVV6RVp0N256?=
 =?utf-8?B?cHExV2JkQ3RXOFpnTk1Rc1dmWFlRSmdxR3JNQWpLQmxyb2N4UnFlZFI4azZw?=
 =?utf-8?B?dWdhQjhLVGI5VC96UWpkZkpnV0pLaVBLaXVWTjBkdDVDUTdJbTFpWklGL3Ez?=
 =?utf-8?B?Sy9qN2p2Q1JPdWU4cmpSR1hGZW5CekF6S0pNby9UWkxYOGNuSU1IVnEwSW1P?=
 =?utf-8?B?VCt1L0V3eUUrOVBsSkhhSGJoSWpKY1g3Mm4zYmM5MVJnY0dwMk9rVU5VVVFl?=
 =?utf-8?B?UUwvV0JndHVaYUoxZndQVTR3RGI2THNwV1dtM2ZsTzJXdFh0b2J4NGo0MXRh?=
 =?utf-8?B?L2NDT093eFllMmVnOFNzUVhMaEQwS2V0aERUcUJpcWlEcEVhdFV1V3JLaTZk?=
 =?utf-8?B?R0RYMGEyd2wzd21rTmI1RkxiR1pPVDR4UkN6bzZTRXh5MmxDNWtleDViY1ZE?=
 =?utf-8?B?NWEyUEM3NVkwalpzSmxaQmN0RXo3VFZ4dlRneWoyNGRIcTE0SFJ5aXgrcWJs?=
 =?utf-8?B?aFRHemt3NWhkSlEzb29FaCtkOHVxUFJjYTkweVlCdjBCY01kUzV4RmFsM2dM?=
 =?utf-8?B?cEVGRXdNdTNQKzV0cnE4eDNVVitGbzVpUms3U2ZBaEJOMVpvTjE4SnVCdXI1?=
 =?utf-8?B?eDFFT0JlWVVHZGxXRGJ5NjNLTHZIcjRTRm92Sndab1lscnFXWXZZckRaQ1pK?=
 =?utf-8?B?RUNkcGtSTjBnelVvaEQ1Ukp0RytGTFlmdm53VHZkTCt4b3ZJck9HTjN1Yjly?=
 =?utf-8?B?RFI4QldabUpnK1IrZ1lXbk5IQkJ1UUw2MTc4NXlLN1I0cGZnbnkraVhicHBN?=
 =?utf-8?B?clZGZEJFeDF1UUpNY1l2NHZiZEllZTRvbDlFYWVNRUVZWCtjcU5FdjJndWVr?=
 =?utf-8?B?Q29aZFM1dElFUHBrRXJ4aEpLY2ZMT3cyRXNlUEQvMENSbTdaR2JGOWhNR2Ev?=
 =?utf-8?B?c1FORDZHanJ5NkNDa25vS2RtWlJ6dlUwWEpHNThUMnFDcXR6WUloNzlCTWZR?=
 =?utf-8?B?OUF4ZUxhTU5GdVhjakdmdGV4SFRPYk5nQVhkblFSS3RnL0pQeEZqTTEwRmc2?=
 =?utf-8?B?bS93T0xZZWtLNWMycEZydkZVSlNMRWI0VWxkdzkvQ29JMmJteWRUV080aWU0?=
 =?utf-8?B?RDhXTWUwc0NscXVVU3hrSTc0ZmFTU2w0M1dtUmc5VDZiTW40UEtrYmxQV1B6?=
 =?utf-8?B?aVlWWDNDR0h1d2JiOEo3K2NmOHZ3RU13ZjByQXlvcW9uNU51SHljdz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e721e96-fd1f-44da-439e-08df2a8444fd
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:19:29.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZHVI4H4xa6iuukmfncv2YWOPULNN88dhYmbkVDSVoYEaoEtPV3YR6EykRJcsHpnE7yFkKWGERwr4JIfdv50yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7405

On 10/14/26 13:53, Sebastian Andrzej Siewior wrote:
> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
> 
> On 2026-10-14 11:15:05 [+0300], Vladimir Kondratiev wrote:
>> On 10/13/26 18:27, Sebastian Andrzej Siewior wrote:
>>> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
>>>
>>> On 2026-10-12 12:12:59 [+0300], Vladimir Kondratiev wrote:
>>>> boolean flag don't protect from race when probing several instances
>>>> asynchronously. On system with multiple APLICs, if probed asynchronously,
>>>> warning triggered as below.
>>>
>>> Why is this async? Doesn't __platform_driver_probe() set it to sync?
>>
>> Yes it does but aplic driver uses
>>
>> builtin_platform_driver(aplic_driver);
>>
>> that takes different route. Easy way to directly proof it: I boot with
>>
>> driver_async_probe=* dyndbg=\"func __driver_attach +p\"
>>
>> to request asynchronous probe and debug prints in the __driver_attach
>> shows:
>> [    0.236483] platform 48760000.interrupt-controller: probing driver riscv-aplic asynchronously
>> [    0.236513] platform 674e0000.interrupt-controller: probing driver riscv-aplic asynchronously
>> [    0.236539] platform 67560000.interrupt-controller: probing driver riscv-aplic asynchronously
> 
> Does "driver_async_probe=*" mark _all_ drivers as safe and you run into
> a problem where a driver isn't safe? Does the "dyndbg=" argument show
> the driver is probed asynchronously if you omit the "driver_async_probe"
> argument?

Not exactly, "driver_async_probe=*" in bootargs request only drivers that has
PROBE_DEFAULT_STRATEGY to be probed asynchronously.

aplic_driver don't set probe_type thus it defaults to PROBE_DEFAULT_STRATEGY,
quote exact definition from kdoc:
 * @PROBE_DEFAULT_STRATEGY: Used by drivers that work equally well
 *	whether probed synchronously or asynchronously.

If driver is no capable of async probing it should use PROBE_FORCE_SYNCHRONOUS.
3-rd option for probe_type is PROBE_PREFER_ASYNCHRONOUS

Direct test shows exactly this: that "dyndbg=" argument prints
"probing driver riscv-aplic asynchronously" if I set "driver_async_probe=*"
and prints nothing, meaning driver probed synchronously,
without "driver_async_probe=*"

> So the question is do we want to let it probe asynchronously or should
> we force it to sync.

I see no reason for PROBE_FORCE_SYNCHRONOUS to prohibit asynchronous probing.
code itself is capable of asynchronous probing. Preference for particular
platform can be specified in the bootargs.
> 
>>> Would you mind providing a coherent description of the problem and
>>> implemented solution instead of slapping console output?
>>
>> Sorry if it was not clear; shall I explain in details why pattern
>>
>> if (!done) {
>> 	do_something();
>> 	done = true;
>> }
>>
>> is not SMP safe? Add detailed explanation to commit message and shorten console output?
> 
> No console output at all. You need to coherently explain the problem
> without adding console output. This is a simple problem, there is no
> need to for a huge commit message here. Also there is no need for SMP
> here as we do have kernel preemption.

Got it. Will do. 

> 
>> Reason for asynchronous probing is simple - to reduce boot time, it is critical for embedded
>> systems. Think of system managing car rear camera and proximity sensors, it should be ready when you
>> start driving, this lefts very short time for the kernel to boot.
> 
> So the driver does not support async probing and you add it and call it
> a fix? I don't mind async probing but it should be declared what the
> actual intention is. And maybe the driver should be marked async in the
> end.

As above, drive declares it is agnostic to probe type, supporting both. So
I do think it is a fix.

>>>> ---
>>>> Changes in v3:
>>>> - drop __ro_after_init attribute due to write to read-only page concern
>>>
>>> What concern? That __ro_after_init can stay. It is built-in only.
>> See comment to v2 by sachiko-bot$kernel.org here
>> https://lore.kernel.org/all/sashiko-outbox-167856@kernel.org/
>> quote:
>> ---cut---
>> [Severity: High]
>>
>> Will this trigger a fatal page fault if the probe is deferred?
>>
> …
>> Platform driver probes can be deferred (for instance, waiting for an MSI
>>
>> domain) and run in a workqueue after the init phase is done.
> …
>> and indeed, aplic_msi_setup() can return -EPROBE_DEFER so concern is valid and
>> existed in original code, it is not related to asynchronous probing
> 
> I would not expect the MSI domain to be probed after kernel booting via
> a module. This is the scenario where this would explode.
> And if you consider this a problem you should address it and denote it
> in the commit description as such and not silently changing it as part
> of another change without any explanation.

OK, will add explanation for this.
This driver can't be a module, it is "builtin_platform_driver(aplic_driver);"
but still probe may be deferred if of node has "msi-parent", see
aplic_msi_setup() - it can return -EPROBE_DEFER;

Thanks, Vladimir
