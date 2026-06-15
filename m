Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3653B47CF
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506815; cv=none; b=RChuJE7R2PZR53buTO8ekxNO9KC8IapohdrZ1X7IiUa8aLpMNcwu3Huxn3C9EihznmeoRKa1cuItMJdUNphB07XW57/het4T02QP3rTjYO58NFCWEu+o9Mle5TZwP7EVLF2lEqdtZ6MnEvHIcP3XfQ9NXDe8/wP+j7H4flT2nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506815; c=relaxed/simple;
	bh=gn2ssXC1ejqemrvTuLo38/1m205JY8o5WvjCLUAl4Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eyel46IljNPnY3jBfzl5a/wMhCex/p6vhxWxW60CiaEikFHJdm020EdWyko6tRnV5/aUKUlRySFAtb+CYufNVcUggSF7G95YDpAjn0AmThJ+SStX12/F10PzkskfZbsnfNJC3R46srPHNyTaDpyvlA/XXyas+ZnVRqtGm1A7CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4Jp6FKf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4Jp6FKf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso21841485e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781506811; x=1782111611; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8w8xq/4mVkW1zPaq+z+yq8eteQWjYrXoGXcozsWmpc=;
        b=F4Jp6FKfP0OD8SO7s2jrIfVE9u79pPaWKH82N1TdB3bPQoOWJiCxqa51uAMpSIl6k9
         +HeCx/C2rKA4KcSQOON45MarbYsQbJnHsdq25qklxi0t/s2flDVaxT0Ptl7OC+3J+rHf
         6K0yDoFwwGaYAWmt1F5YR1Hgu37SyF16Fhq4qGYxB6ykg9EzhOLDDBpoeFyT7TSex0yn
         dSEyhgRIvQKs91rLkpke8DNLrkciAHf0obxWJwqIYHeeOnVEGINgokGU8p8XkLy+sIrj
         5Hogh9oiRjjvfdDtf7qRCDjUvE3leEylk2xOoGAmxPhM1n2CCxoRZ2IMCdYtdgY9vaPL
         qClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781506811; x=1782111611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8w8xq/4mVkW1zPaq+z+yq8eteQWjYrXoGXcozsWmpc=;
        b=lLQUvHsxQU8EkkbYrj7WPyPEjE5b4MUVpc55Nc/IbYH4ny3tlR0vRMaEp9QcdUvXx7
         Dt47fakqbtOgAUQ3SqLRJwZO/7gf70QVw3rEKIv4F+Sb20V078ld6WQqsUTvzHkgeWkD
         Xe2BP/06ylnGQcKzLdIHjOmDkLL+NBoq0idIKAZk6TDsPAMhQlrfP5q4qUQxY3Epe0Zm
         javgXLPUbJ4z68iR2GxikDE6PLy39Vyzqn2fFG+2+awd0FeFgy+8knUrYrM5TU/8sDyK
         5KpmlsHdQdhOrRGr/b+2cJajLPZB4nQ7eygE5NzyO+eKIZRCblQCds9wyilnt/ykHXaR
         h+Iw==
X-Forwarded-Encrypted: i=1; AFNElJ9+GNgAnq0IL8eLX7D395Kn+JZ9DRgdVBD4EBipJ3evtTFZlfFs4SjcepghuxueRAlkTy6Ugb+f/TigQI3O1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGZSdTND+Fm9560xjbo7zBZFxYtTp/LonZu5GYR+d5cKOUnNnI
	rY6fzgUovKSUppRcw//U0t/QpXo4nPtw1tqHr/T7FaA0GfupL3Jdt3QB
X-Gm-Gg: Acq92OH+NM1VJFMqR4GnJGIba94CvfSMLeBN7tyvkVf5n1Hl+u0ld5WMytXm/SsPPfB
	D5o1MhXWgpGSpsdzAuuwgnkxhXkwyxjtjK6kaWRNMK2Ivg0dkb60rb/KQHTCm+IGZhUzi/yN/QX
	AoPB/lA95CClkoPdM1oiP8I1SgU/or1AePsIoNgWBwUeXMT8Wr/uO+om6L3QjYc5qN9YDWJtm7J
	X+SWPDnGNjDEcJ067u3zZZz+aHRP+GBojSWJUsbZpPn8mnHy7Oe3Cp3hHcWwqdyuDrME2FHQKOW
	8Pe0067y8AFBsa2oS4b/oEJXJV+NpCreM8/dDKuRLsC81287GFgxqL2nFDwzUcoN7jDILaHS/1p
	Z0cIgP11fUZ4qeSCgITrnw/TN7A2Q7to2ULanr4cGdhwDWRm/MrXZKWlAAq8rG+cih6uifvfAj0
	PsnE/ll+HkiWNe67WIBQTbL801ISp6B4NQrwPnZwFRUSgcLtxq+GdjdXArQ9qR/BHawHHg3LeEa
	PcOBiRxxTJeYUGhUiMmk69yRA==
X-Received: by 2002:a05:600d:6447:10b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-490ec501b2cmr122824265e9.19.1781506810190;
        Mon, 15 Jun 2026 00:00:10 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a399fsm217664565e9.0.2026.06.15.00.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:00:09 -0700 (PDT)
Message-ID: <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
Date: Mon, 15 Jun 2026 09:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Huacai,

sorry for the reply delay.

On 10.06.26 08:05, Huacai Chen wrote:
> [...]
> In theory LoongArch has the same problem, but I cannot reproduce,
> should I enable PREEMPT_RT? Or there are some special configurations?

Sadly I cannot help with that. For MIPS, this seems to be the default
behavior.

> Huacai
>
>> This issue was noticed on several Realtek MIPS switch SoCs (MIPS
>> interAptiv) and came up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
>> branch. The patch also has been backported all the way back to 6.1.
>>
>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
>> and grace periods can still complete. MIPS shuts down all CPUs here
>> without going through the CPU-hotplug mechanism, so this report is not
>> otherwise issued. Reporting a dying CPU to RCU outside the regular hotplug
>> offline path is not unprecedented: arm64 does the same in cpu_die_early().
>> There it is an exception for a CPU that was coming online and is aborting
>> bringup, rather than the default shutdown action as on MIPS.
>>
>> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>>
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index 4868e79f3b30..0f28b4a62e72 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/err.h>
>>  #include <linux/ftrace.h>
>>  #include <linux/irqdomain.h>
>> @@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
>>         set_cpu_online(smp_processor_id(), false);
>>         calculate_cpu_foreign_map();
>>         local_irq_disable();
>> +       rcutree_report_cpu_dead();
>>         while (1);
>>  }
>>
>> --
>> 2.51.0
>>
>>

Best,
Jonas
