Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107ED335097;
	Wed, 21 Jan 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993998; cv=none; b=Ub04lfCDNJehrjpD1Z6zhKBQh8CEH2W7n2cTBusx2asSoKrRKagldIcZcIi4SmEp1YRGB6ZjLcc+j6orYF/ZX4kezXWv9QUASCC9C4ZWiEhadqDY1HB57cjZvQhukRqurvLvpOlVQnUhXytTsQi+zH3lSsDQLMV1lBsfY3WFf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993998; c=relaxed/simple;
	bh=8nIStO62/pj08BGcjmkSCW+2d8pEoCW7q94cFfuT93I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw6M4pzBMe61MN44VvYaK7gg1CFyeSIBcmKSAGgdEunW+zY4YLgmiwoR492O9Fbyj2ayQWgFBLgUjmhf5JdSyBWelI2gA2N68Dz33Q8+AbL03Q9RWlbG6hvKO1aS3zlUB+CrAYMPT+0OcTDjOJRUcE5YGp9+MrieW39K2xRY1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF5FjrMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF5FjrMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDA7C116D0;
	Wed, 21 Jan 2026 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768993996;
	bh=8nIStO62/pj08BGcjmkSCW+2d8pEoCW7q94cFfuT93I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XF5FjrMQ5bszsg63Pif9qx/FPth0mMM/YZ1y7dfq9g6q5Xcnpzm6YyxIgRMr2Gd2C
	 ti70ZYlixTilTQ72tjO6xoJ58wqMoeY6wuSJGLo/Dw8X9Z9IcDr4+n8zPQ1kWieRqv
	 jieLMFHluglL3HPMN8i++15ZkDLtsEKl3fU85YGoMJjfjXQYYMT729BjiJfO8Vgs38
	 X9plq940F7aXh+PS4XBdaQ+5ge4wlgk4JxmfwS1OOGeD5QkVpyTpcRJAiliX1c0UtL
	 NdLqZ1BoTlbD+S7abMh5J4LaWFiJNvhm7dcwzT76M8oE1pKOcQVQUQ6MClut3PF7zH
	 WcNc5MjqZmCZg==
Message-ID: <80325398-80a4-486a-ba4f-f2b8a23d7b17@kernel.org>
Date: Wed, 21 Jan 2026 12:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION on linux-next (next-20260115)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 sfr@canb.auug.org.au, ilpo.jarvinen@linux.intel.com,
 regressions@leemhuis.info
References: <555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com>
 <20260121075348.5MyqcHFB@linutronix.de>
 <89de03a5-e5da-4d2e-8547-8e54ad73b324@intel.com>
 <20260121090154.Lpaj9hrr@linutronix.de>
 <1a68f6d5-6541-4b04-8628-397001cb1e55@kernel.org>
 <20260121103921.q-r7pAzL@linutronix.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260121103921.q-r7pAzL@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Jan-26 11:39, Sebastian Andrzej Siewior wrote:
> On 2026-01-21 11:20:53 [+0100], Hans de Goede wrote:
>> Hi,
> Hi,
> 
>> Right, so as the commit message of commit 8f812373d195 ("platform/x86: intel:
>> int0002_vgpio: Pass IRQF_ONESHOT to request_irq()") explains
>> the int0002_vgpio driver *must* use the same flags to request
>> the IRQ as the ACPI core does, which is why it passes IRQF_ONESHOT
>> even though it does not have a threaded handler.
>>
>> This worked fine until commit aef30c8d569c ("genirq: Warn about using
>> IRQF_ONESHOT without a threaded handler") as Chaitanya's bisect
>> pointed out.
> 
> Avoiding forced-threading on the int0002_vgpio handler is actually a
> problem on PREEMPT_RT. But yeah no complains from the stack.
> 
>> Sebastian as I agree that switching to IRQF_COND_ONESHOT on
>> the int0002_vgpio.c side is a good way to fix this.
>>
>> But If I'm reading your proposed changes correct then your suggestion
>> is to drop IRQF_ONESHOT from int0002_vgpio.c and then instead of
>> replacing it with IRQF_COND_ONESHOT you want to always pass
>> IRQF_COND_ONESHOT when using the non-threaded request_irq functions?
> 
> Correct.
> 
>> I'm not objecting against this, just making sure I understand
>> correctly.
>>
>> Note in that case you should also add this to the non devm_
>> prefixed version.
> 
> You mean request_irq() as it has been done in commit
>    c37927a203fa2 ("genirq: Set IRQF_COND_ONESHOT in request_irq()")

Yes I meant plain request_irq(), I was not aware this was already
done there.

Regards,

Hans


