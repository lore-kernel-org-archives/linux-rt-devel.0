Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CF326939
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965718; cv=fail; b=k2hMf8aVUaHnRpnsTygltbPGomDu4I7mqxeJ2s0FBLMlPeqbEYNcLO0HVQqUCGMhHIew5opQFy5WtcNxeuuC/+4oI1y6yl2yrX6VFmPGPbupDpXbJ3LRpCcM8Z7033DHUtB0mnY7k376WDRsxuN1l7vkmCLRrGbN/m13Aj78oyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965718; c=relaxed/simple;
	bh=bntkQ44wbycSU21UDcOj/5RabQy5QMxawxPRjtxccRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdeKIdsZGkl5GHIqONGBFQUBswh7O//D7VYAHslZox48WEM3qQ3cl5WnfduLc+2gJB7FTvfJCEn7A3Fn++rPci69cmoiGWALZjAL77J7pvY2tpH4rCco2c+DM1DITLz65NOoYlORQaC3KIUBMHJsgwROtCygSrumBW8IL0Qo1OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=RVMaAfPH; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="RVMaAfPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8VbHqS9fYn+EhKvrg6isJaXvUb6WPG3O5AYjzop1IPhv2tBhme7NqpK75PJk3MQk/Z/7+X0WCyFVfYvxVqZzQZMOWJBmDdYQk4a8sN/HjytrgdN2XNbgm/zOFXIxsdWThM3oxDTN6b7mFe91nopPbNCZK5lLRRuWTPBk8SiJYTfoiyz+XwTvbjckP+VwBGQ49ZcVt5H9CsCB6/3je5VBSkcq0xxgTK7igEvf1cqaZ7QdquZRAbnryHw+ZTZExXtMr/W6r2jMn2XHMSAYQbxrPX4H5meL6OfBREcmq00rj7jLPcum7f1ttvK9gngd1E6wzCFb89fQFBgkMgl9lF2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqLEHsuzZkGwLtAQn9mMWftrpfK3AEwE2EFN79zo4vU=;
 b=e42brZcFwuEMpL91hurUvdMY0qqjSCuot6uqyxqEXIgAtwYW+V0vS5wGfSCIUlbQ/1IymXIwE+VOliQ5hvBVIFc26QkG3379J5GS71JA7TgDFDTlMGyIaY3VOCX/sfUFf+WWYnMk8XKiTItEs546gMLKQ6gmO+jI0LkG6LJrbi3kKKJbpRdxcIbyx81Wqxr/KNgVKsFk2/Bbi0BszIVmJmSDKStoMW0UaMeL1BDIKBylpFm+nBJu/5DNJNiWgCmCl1DGu1Ac5kkmZt2zR8PqAdtBGVEcarwL3z3D+DbsXj0J8FZEmfOv50G8BGhPYWLSBYR044UVizwIcA7x1F77QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqLEHsuzZkGwLtAQn9mMWftrpfK3AEwE2EFN79zo4vU=;
 b=RVMaAfPH0KJA2jtWZOZ8KY7pgZBVUePO88AAM7z1BwgVelWYK0n3u6koDremq+27khLYm1LidB/wBYhotjOv5NVd7K9hPfUvOx8uueQ6LY962lGT95vN3KqgEaVS58LKCJOmctJk0bgif3zUnVRX/fvu7WCMYR+T+Bmk5Z0TDw8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from MI9PR09MB924131.eurprd09.prod.outlook.com (2603:10a6:290:86::5)
 by DB9PR09MB6644.eurprd09.prod.outlook.com (2603:10a6:10:4f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 08:15:08 +0000
Received: from MI9PR09MB924131.eurprd09.prod.outlook.com
 ([fe80::fdde:8804:8594:8394]) by MI9PR09MB924131.eurprd09.prod.outlook.com
 ([fe80::fdde:8804:8594:8394%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 08:15:07 +0000
Message-ID: <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
Date: Wed, 14 Oct 2026 11:15:05 +0300
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
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261013152727.2cUDX3l0@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To MI9PR09MB924131.eurprd09.prod.outlook.com (2603:10a6:290:86::5)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR09MB924131:EE_|DB9PR09MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ca538e-0e8c-43e6-d486-08df29cb425c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zmcfMGR7K226LKyccNJ8gbVAaftHF90VdTiq92k59Uwj8b0SISKy9PsM8BSeqyJ5CVyXP0Y44bvtMRFBYej25oAUVWk6k0D7KQCMCwNw3Q5xruFY4KCDT9+Pm3q+chbS7AZ1neXYow6JN2KEgo2WAORiUjlkngMXxeCFdWo1ZtL2CgUNprrjZDqu6+J8jrlSewn+FzsLxBfzxHrm5J4pCI8F+Pc40jSWiKIEgg5I3L5RZmAl8oqml8UehLWNE7GGCFuw/1qF1YO1Md4Q6D1IILceC8oWPSxbr1UH1XsFmLE/iHo1UcGUSgoD/yvJP+0bBljGup95j4hW39uPMurvDMDkQtlVDa+8qwHaSCAspKxygWj9xztAYA41O/qwSRy/Mm8yGPc2EQHT38gNt6UYUQRlfXEtOHo2mAYac8YwTHsHzy1GKytqDp0P2sE+9y/6ePM6kV1f0weCi8aNu/1WD7LK0ICh7E62GfmxmwfxB+Y2/DqeQjhm0/j7DdL7YIUlZR57yiuJObG0c5l4DK4oFN9vtdGHeLlOaIRgf8tqwtaEf2raVgAvfh8/IHGx0OKMrEwVwZkbRtI44Lj3EsfUkQBFoxNkBuSfyNl2Gku3DzvcIc1Jt52blsF8D0Vy8hX9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR09MB924131.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjA5SWxHZlR1TEN1R3NYSG9WTTNaVFRORVc4V2NoYlVWSlA4QS9QMlJDRVFr?=
 =?utf-8?B?YklOclBkcTc5NEpTZGpXc24yMmlSMC9McEVWOUVJbEtQVkhLNlhYdXYzVnVr?=
 =?utf-8?B?SFBBVWV5eWN6SDF4VkdQQktHZHk1OXEwQktQTFN3N1lSeGR1dFh4NG82cDFV?=
 =?utf-8?B?c1piRDI5WnVmSXh5MGhSYlYzc21aZXVGY2ZjQ2w2d3puZEhmbVBuU1hSZEJE?=
 =?utf-8?B?QkRWS2pvbjhEQ1BZay8xWmloZk1HQnEzd0JVNGVYTTErV0cwWGluWEFtQVln?=
 =?utf-8?B?dU9BWG1MRUdmZEk2aTJxWThITFpDdExCb0pXWnN4SkZaaER5RXdWMEl4TW81?=
 =?utf-8?B?M3ZJUXdzek01bEtuRGRNdDkvNUY2UXJTSW1mWHhwZG8xK01rMVMvd0huTnBS?=
 =?utf-8?B?RHRrc0ZNTEQ3MXdQd0dWNSt0RVpjL0VCUktNcjE2SEo1V1h4QjlWZDMyWklO?=
 =?utf-8?B?Y0JJOGY5TFFQa2ZjZ3VXRE53ZEUvNDFMeU5naUtZWjNUc3JGSHlhNUp0dkNa?=
 =?utf-8?B?bC8rOHIya3ZINlF0QnVTd3krYXhLRjhqWTZUVHVXQzBkYVVyL3JUZGRXTkU3?=
 =?utf-8?B?aTlkWmJONnI2SlNSSUtHUkc3eUhJbXZCYXFSNk81ZjFRQjRpQ28wZU9DWTRp?=
 =?utf-8?B?cjBUZ3krVmc1TUl1QXo0eGxkb0hGdzc4cVpUZGU5ZS9SczJvdW50clNERldD?=
 =?utf-8?B?d0Q0VVRncmI0MWJTT3NTZnFtTVRTVmZsQjZ2eWFHL0dPN2hGcEx4UWkyTW1p?=
 =?utf-8?B?WDV1ZC9FWTcvRmp3ZTZGbzN4a2labmttUlEvaklkdFZQenAzdzRWTi90TWhZ?=
 =?utf-8?B?MlpYeUJ0TlhZNFJMUnFEUVZPajNjRU0zejRCeitHNzhYUUk0a1k4c2tXS01M?=
 =?utf-8?B?bWF6MmVmQU5wT0tiOHdkUFdlN2tiZkFrTGt4YWwveVhvM29pZDgyeGI2M2lu?=
 =?utf-8?B?QjBJV1FaYXdIeXZkU2dsU1VjRkNUTGg2YzhobVFHTTBZM2JiT0g1ekRtaTRn?=
 =?utf-8?B?bThCOWZaSk0wQzFoOFJKR0JyZmdydkFwSkFjZkx3ZVpQNzRMODhSb0xwdjJV?=
 =?utf-8?B?QTlVUkVKSFlmOVI1WE91Y3l6VGNLWGxZcXg0VXdKdnJTRXhab0Q2TTVEblFW?=
 =?utf-8?B?cks1VzZRK3Eyb1V3QzU5QmtBN0xZVWMxQ05CV01DVE95cE5HeXRyOEhra2Z4?=
 =?utf-8?B?cFhXMzF3T1dZQXJEVHIxd096cVRhOXNiR2kvMnpFRlA1Z0VYdjRBZE9BMVFC?=
 =?utf-8?B?WUMzNkhHaXFqMnFmOWxzMWZ4YmYyOWVjRTZKVkZLeUVBYkpQelJySTVrUTdo?=
 =?utf-8?B?aVVLUEcyNlNRc0M2ekpVcDRCWFRCUkJTOTJJMmZYaFZCaEdrZG5VOGFNVDlR?=
 =?utf-8?B?bHVZZ2NYTUpkSktpVTNVY0hBbVlvY2pTd3VBb3E1Z2ZNc21tcFpOeWpwV2p5?=
 =?utf-8?B?K2JPaExLcExBRFIzUjg5YU9naTVnNjhqTVViLzVDV01vQXErVEkzcjRBOXkw?=
 =?utf-8?B?eWgyenNha0Q3VjVUc2t4cml6NWthU1Jqcm4vNGlnTkRGSFJSWFNRMHZ6elFt?=
 =?utf-8?B?RUlsVWtiQnNtaGhDQXVZMEhHcjcvVWtBVnV4VlJZYm5nQU1xTitsR2NuVXN0?=
 =?utf-8?B?OUQ5ZjBlZHFONkp5eWZ1MytZWXdCaExZdGtpMjNmazdPcG1YY3NSVnE0Wjh0?=
 =?utf-8?B?eWc3VndxWHJ3ZXJlRVc4NE9EYm5SQldGbUNIc25kSS9qTFFNdFlwaWdwVlhm?=
 =?utf-8?B?VEhHcVJkRGlvQ2t4ZVpjbHlVcUJ0RVJhbHc0VUJXcXBUOTVjTE56K1hpTzR3?=
 =?utf-8?B?WU0yYjFLOEUzQVR5ZnpUMXF1ekkrSGZFT3d1a3lrQVRHcXVvNVU1M1N1dDFk?=
 =?utf-8?B?U0hlalJKV3lXbmxSRDNuaStLVkZ2TW1SUTRkK3BJUUNzQ2NlYTdSckFwbTY0?=
 =?utf-8?B?dldxQzhLR3ZieUFKK0tLTlpYMDB5aTBnaExNc1o1ZHM5VXovbDhGWXZPK2Fy?=
 =?utf-8?B?UUVGYm91NVM5QWtzRFlrS0o3S082SjlybUI4Q1U3VDZtTVdabUpEWjVMVmRZ?=
 =?utf-8?B?UDcxcGxKeit4eE56Zi9LbnJrSHFjUGlaQVU2bjl1RmloMGhBZ0VyaUM0RnQ5?=
 =?utf-8?B?YTRsUzFmenhITzNrQlNZaGJqTFl2c2RlNlJvVitQSGx0T0JzMGM1a3FVSUdq?=
 =?utf-8?B?djF0STdULytwcHNGcmhPUURjcnl1ekt0bGFNNWN3QjgvYWNuUk1iSTF4Ulcz?=
 =?utf-8?B?ODZ3M3prbWh2a0hrNi83NThINHdQY29CVzFUb2JHUXNIdGpQbThmYkt3TTJ4?=
 =?utf-8?B?MXYyakRmKzJsTkx2TGtlOHZNcFFvZ05LRWl3OTF0YWh5Um5VaWlWQT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ca538e-0e8c-43e6-d486-08df29cb425c
X-MS-Exchange-CrossTenant-AuthSource: MI9PR09MB924131.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:15:07.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 861R/l1IYtTJ1e+xexBQwovxhDy9SuJ1z/vG4fiXeKpKCWAfZQUMbRae4w6RHb6CeW8AE3gwpxsZbHXbHVc9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6644

On 10/13/26 18:27, Sebastian Andrzej Siewior wrote:
> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
> 
> On 2026-10-12 12:12:59 [+0300], Vladimir Kondratiev wrote:
>> boolean flag don't protect from race when probing several instances
>> asynchronously. On system with multiple APLICs, if probed asynchronously,
>> warning triggered as below.
> 
> Why is this async? Doesn't __platform_driver_probe() set it to sync?

Yes it does but aplic driver uses

builtin_platform_driver(aplic_driver);

that takes different route. Easy way to directly proof it: I boot with

driver_async_probe=* dyndbg=\"func __driver_attach +p\"

to request asynchronous probe and debug prints in the __driver_attach
shows:
[    0.236483] platform 48760000.interrupt-controller: probing driver riscv-aplic asynchronously
[    0.236513] platform 674e0000.interrupt-controller: probing driver riscv-aplic asynchronously
[    0.236539] platform 67560000.interrupt-controller: probing driver riscv-aplic asynchronously
 
> Would you mind providing a coherent description of the problem and
> implemented solution instead of slapping console output?

Sorry if it was not clear; shall I explain in details why pattern

if (!done) {
	do_something();
	done = true;
}

is not SMP safe? Add detailed explanation to commit message and shorten console output?

Reason for asynchronous probing is simple - to reduce boot time, it is critical for embedded
systems. Think of system managing car rear camera and proximity sensors, it should be ready when you
start driving, this lefts very short time for the kernel to boot.

>> ---
>> Changes in v3:
>> - drop __ro_after_init attribute due to write to read-only page concern
> 
> What concern? That __ro_after_init can stay. It is built-in only.
See comment to v2 by sachiko-bot$kernel.org here
https://lore.kernel.org/all/sashiko-outbox-167856@kernel.org/
quote:
---cut---
[Severity: High]

Will this trigger a fatal page fault if the probe is deferred?



The aplic_syscore_registered variable retains the __ro_after_init attribute,

which places it in a memory section that becomes strictly read-only after

the kernel initialization phase completes.



Platform driver probes can be deferred (for instance, waiting for an MSI

domain) and run in a workqueue after the init phase is done.



If a late probe calls aplic_syscore_init(), atomic_cmpxchg() will attempt

to write 1 to this read-only memory page, which causes a store fault (or

AMO fault on RISC-V).



Does the __ro_after_init attribute need to be removed here to safely

support late and deferred probing?

---cut---

and indeed, aplic_msi_setup() can return -EPROBE_DEFER so concern is valid and
existed in original code, it is not related to asynchronous probing

> 
>> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
>> index d9afb6ae98cf56d6fd9f858c31a3d23546c3b450..54e1d5602f15a04127e900c0a4983022d49da553 100644
>> --- a/drivers/irqchip/irq-riscv-aplic-main.c
>> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
>> @@ -116,14 +116,12 @@ static struct syscore aplic_syscore = {
>>  	.ops = &aplic_syscore_ops,
>>  };
>>  
>> -static bool aplic_syscore_registered __ro_after_init;
>> +static atomic_t aplic_syscore_registered = ATOMIC_INIT(0);
>>  
>>  static void aplic_syscore_init(void)
>>  {
>> -	if (!aplic_syscore_registered) {
>> +	if (!atomic_cmpxchg(&aplic_syscore_registered, 0, 1))
>>  		register_syscore(&aplic_syscore);
>> -		aplic_syscore_registered = true;
>> -	}
>>  }
>>  
>>  static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)
>>Thanks, Vladimir

