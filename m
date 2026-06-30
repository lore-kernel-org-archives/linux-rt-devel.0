Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB732F7F06
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859756; cv=none; b=BVkMWcEoNSHOff2jxHpZiJriDHFPB6y2HezQU6CZh7pqzizWPCJ/4YuLusNVwa/2U7pIrLDMueWACiWvSynUz7VDb8bAlJyCVaQRn6hAZOMemfJs97MbgoJz/fFLIQ24peVeoIbcOxD52gELQYaCxDtTdfVFltyfLW8kKaw5l8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859756; c=relaxed/simple;
	bh=O9TcR4Yz6DpFSlXvr+yDzPu4H7AnM/KEd+rjjy7XQeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWcAALiDVPj2uFWZYPrNcA/tlw3TgZCzm0eqDX66jjczKt2O//Iqo/WyfXhHqNMffH5WscQIXUrSes2rZrLkMBEHUAPN1dv/APzNzWg9yv4O0cJ7MX0MJC1I9H/d7I126V9Ym9dHN/1bZnmF75tahuFLI5kedVILQhuVChtEcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC8t2jQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC8t2jQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8381F00ACA
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 22:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859755;
	bh=O9TcR4Yz6DpFSlXvr+yDzPu4H7AnM/KEd+rjjy7XQeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HC8t2jQ2/HGMqmkqGMzFl4agsKy36QdWakSf8PPuxWHKx/LWRDvUvaYTa7ldTAeVm
	 KcX3Ym/2XwS3JOQwCAziybbvSw3M+ktL8Ct5qmJ0JLjJGWyg6KmNMmU9Z2kUGIvxHJ
	 wQmWxA5AB2J4G6PEMEcofVUbIHHvE3L9RpUBLGiobdy5TZ0+vhFV5jzSJNYR2mpsn+
	 wJhKTADsJdCEdKj5HcdFBrAGEqoqdxD0hGYXDUuyV7q7uBHXLd77ALaWcmvoDj6kgR
	 6Tti3Wr6L3Y59cuJjLRBe97EWNYIomRnk56RspIubjCnSf1rGwtEloNeZxJLPfHMl/
	 wDOvz71FDM+sA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aebba706b3so2419159e87.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 15:49:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rorh38oWHI4ewC48gdvLc2O04jnGbZIQ5nhhl3o9oKvFXqqN6pO4LJetD/iMw1fSeIB3jX9TM07eHI24502bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqu5J05lcVlVZ9PygKMKLzyKmK2fokqsd2M19h2A0i+3M+f5pa
	pV6cQDs+OVooWpf9uTvtG4lnGoHB/NhK+xDD+LrGYlqDsheR//uKykyxmBLrAE9A6XJpBzrlIDp
	B2/9+gwHMUxaCh163xd/B//DyCCc6x40=
X-Received: by 2002:ac2:4282:0:b0:5ae:b8b6:9e0f with SMTP id
 2adb3069b0e04-5aec10c64eamr420721e87.49.1782859753827; Tue, 30 Jun 2026
 15:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629123349.134224-1-xieyuanbin1@huawei.com>
In-Reply-To: <20260629123349.134224-1-xieyuanbin1@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:49:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLmB-rC3ejO1xMF+UVdknajZAO9=U_UUP4UxWi7dh8zwSQ@mail.gmail.com>
X-Gm-Features: AVVi8CfsNtv33yTJavEkZjfKItNx0ahdwl6_AjkyQ9VJvpvjz0AXqCxApaI8BTc
Message-ID: <CAD++jLmB-rC3ejO1xMF+UVdknajZAO9=U_UUP4UxWi7dh8zwSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: enable interrupts when unhandled user faults are triggered
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, rmk+kernel@armlinux.org.uk, arnd@arndb.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com, lilinjie8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:34=E2=80=AFPM Xie Yuanbin <xieyuanbin1@huawei.com=
> wrote:

> PREEMPT_RT requires interrupts to be enabled when sending signals.
>
> When do_DataAbort()/do_PrefetchAbort() triggers unhandled user faults,
> that is `inf->fn()` return a non-zero value, and the interrupts are not
> enabled within the hook function, force_sig_fault() will be called
> with interrupts disabled.
>
> This can be triggered by user programs executing the bkpt instruction,
> with kernel config CONFIG_PERF_EVENTS=3Dn.
>
> Enable interrupts in do_DataAbort()/do_PrefetchAbort() when unhandled
> user faults are triggered to fix the issue.
>
> Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
>

Skip blank line.

> Suggested-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

I had something like this in my (currently put on ice) generic entry
patch series:
https://lore.kernel.org/linux-arm-kernel/20250225-arm-generic-entry-v5-30-2=
f02313653e5@linaro.org/

This goes in that direction so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
