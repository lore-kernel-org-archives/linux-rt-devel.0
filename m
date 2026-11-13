Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562249;
	b=qeWGSbjeKN5Q7D1UObg5wpnx3Z1X5HRHvguk0VsREYjr1+zVRzdGNweaHVtWb6AEwuNM
	 45R9rBNlEiNC4EMLUdcfuLr5xgXvbM3sGo0yJkk8vEz5Z5vUlGXp925rmzHMoosPZVsI1
	 mcK0JZc+mx5BcFazNjvLjbaVZdL5s6suYhMsOf6yR1yYl9iRnbJJKY9o6mjF0vJdtIX0f
	 ia7X/tEHKRLxuR/yv3cvth9SqJud+eZxaIn2xtelunr6K3MwCxLU0j+KPtDH8+V5YmMC6
	 68VhifX+C5x05fM626+nmqnN9R10YfajkCGV3hXKIOaNU+fb86ZlvA9ScSI9SFupUjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562249;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
	b=X38r0K3rRJFqk0g0wyqrY+pyY+ymtcD9DCpkM8e4GS+Z7nic3axqLpFWmYJmhn6TQqAl
	 ZnD7WFkGsBAaLIc4p9nbBEKzgQ5Y67ES0CYRULRT5W4u5JTk2QYBtN7Hs5ZnXO0rgP8Jq
	 j8zKth/gYRwKK5hrwEVOpt1hQD7R0b2OfAkFmcDgwCAXmn7B46FDnwSRD6qTZyq2eWMhZ
	 +o36Nn7Hteh9arE+xCTOr2VcBRNz4Tn8YMoIt7Y+42o74GE+08jIZax3OsG9xYanjXLLi
	 40MDklyoeqqRp9+sQ6TOZDl0QsjoM/1tH/HJsVCrum5v/SPDwsD0qLF/bh9242CxWGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EryDSBfJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A18606A31C
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EryDSBfJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794562247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
	b=EryDSBfJ8cNKoRZuJ3r609OZxyhdIGXLLK9nsIisqor4Z8bvstJwIk9A0lh+abqHPopW9N
	vQ66LIjRQ0erKQM3CzBoBvd86t2WT6pghxQszrzT3cTeaiOJfyzKCDgxn8X1OMS1Xrvy1p
	vYYgG4MD54wsU5OkYhwq10m2fpRJVeg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-BYxSKkzVMvebNPpzdZQxlA-1; Fri, 13 Nov 2026 04:30:46 -0500
X-MC-Unique: BYxSKkzVMvebNPpzdZQxlA-1
X-Mimecast-MFC-AGG-ID: BYxSKkzVMvebNPpzdZQxlA_1794562245
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89f84753b43so599878b3a.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 01:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562245; x=1795167045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
        b=0SLQHxAAtKPDGM8ENUYHmvk99GOotRmG6wlGNWESY0gikWdAVVuN/U+eosefwrbAaJ
         55KjbNexvhXLdXtc0OF9ORqGLoQLfd/0glN4etlVzJD/SGRHjtwtZiMl0WyneLFZCh1w
         I6DL29jMbTRAZILlTaofJT1G6H2+m73l6t4d1cEvQAh4BOCbQXPG3Jro/Tz4P0OH92ol
         oiaACO1tX8gcImEC2EHjrln7Aszf2fnqPjJC84DohGEXPwDV9VutUq7NsXHHxFFniLRf
         Ud0wOlgZZQnyW68X6ffg0goJzjykYm+XlaR2k+JDbo1pM3tTwQDfHDavFaV3RT/mRPSJ
         PTOQ==
X-Forwarded-Encrypted: i=1; AL+hErHp+1ENWUcHsP9HMiLklWezkqNR0RePebKSise5sGifnhprbCp6A1TWlz2BPUY9uTH41NjULxz5VrXHqCBuTA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+aDrGAKyPmgGVs7azS5SN6uTPCheONBUM+uJfN1qju4C3ub+nE
	H6gHNsfgnzQG7rAKimikIveTJbNGtVJvnhQnfjaTsP+eJvGRSIfw58c3ZeYV3jAy197DK0WV2Ok
	TdNxufvKQ5GlvBJ0DE/LPzq6rMesq2yO8YnENJhE4Dw3hkb1IFyPP8PhsqvcgH0TisTqL/sV749
	E9+fYkwxF9gM1t2OwagJhD8atdPdI6Eh6b+Bz9zS96mnCNmx8Z3Uld/g==
X-Gm-Gg: AYBFou2amBhxwJgJNwKXHFM8ZHY94pbhWK2NLtg3mgFscIIvdVgg8Jkr1vpprivL0wo
	UR3LNNnpmvgkxm544+Nfje1bsLT6yrI8o0cORoS80cUXUg1QypWVKdLKCz8YMR4bXXJWYoZe+CF
	k3TRMotVNOrf/JhBExBrRgOwL9mlX4ABxmTWiOO/jWBumsFElT2h/jmeruvJz3AUCPdJzYk+3Tv
	s9NdA6J+TZ9VKQ=
X-Received: by 2002:a05:6a00:4191:b0:881:e626:74a0 with SMTP id d2e1a72fcca58-8beb7929222mr1804870b3a.47.1794562245114;
        Fri, 13 Nov 2026 01:30:45 -0800 (PST)
X-Received: by 2002:a05:6a00:4191:b0:881:e626:74a0 with SMTP id
 d2e1a72fcca58-8beb7929222mr1804847b3a.47.1794562244585; Fri, 13 Nov 2026
 01:30:44 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
In-Reply-To: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 10:30:33 +0100
X-Gm-Features: AclHuK_XcAHaq3tn3ZycuByNMRaNhY9m6Xm00lSot4Kx5hwaAAm1rOPSYdVSGFc
Message-ID: <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
To: Daniel Wagner <wagi@monom.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2E9blEfLf_v1b1-hcYAqeFJq1O08RWKhfA4VbrkPNeQ_1794562245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:26=E2=80=AFPM Daniel Wagner <wagi@monom.org> wro=
te:
>
> With -u, the latency timerlat reports runs until the measuring thread
> is back in user space. Nothing keeps that thread's memory resident,
> so under memory pressure the kernel reclaims its code, stack and libc
> pages, and the page faults on the way back to user space count as
> latency.
>
> On a Raspberry Pi 3 (PREEMPT_RT 6.12) under stress-ng --class memory,
> timerlat reported up to 40 ms for the user-space threads, which took
> 283 major faults, while the kernel threads' latency stayed below
> 1 ms. cyclictest under the same load: 133 ms without -m (mlockall),
> 0.9 ms with it.
>

Yes, this is a known problem. I have just not seen the timerlat user
thread faulting in practice, maybe because I use rtla mostly on
servers with an "absurd" amount of RAM. Or maybe I just have not
noticed it yet.

> With this change timerlat reports 0.9 ms for the user-space threads
> under the same load, and they take no major faults.
>
> Lock the user-space threads' memory before they start measuring, as
> cyclictest -m does.
>

Thank you for measuring this.

> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  tools/tracing/rtla/src/timerlat_u.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src=
/timerlat_u.c
> index c80edaf07b00..42aaf1d7f216 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -15,6 +15,7 @@
>  #include <pthread.h>
>  #include <sys/wait.h>
>  #include <sys/prctl.h>
> +#include <sys/mman.h>
>
>  #include "common.h"
>  #include "timerlat_u.h"
> @@ -69,6 +70,15 @@ static int timerlat_u_main(int cpu, struct timerlat_u_=
params *params)
>                 }
>         }
>
> +       /*
> +        * Keep the measuring process in memory: the latency it reports
> +        * runs until it is back in user space, and a page fault on the w=
ay
> +        * (its code, stack or libc pages reclaimed under memory pressure=
)
> +        * would count as latency. cyclictest does the same with -m.
> +        */
> +       if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +               err_msg("Could not lock timerlat u memory: %s\n", strerro=
r(errno));
> +

Can we make this opt-in, gated by a -m/--mlockall option, like cyclictest?

We can add it as a boolean field into struct timerlat_params and pass
down to struct timerlat_u_params. See e.g. 2ff4464e3283
("rtla/osnoise: Add IPI tracking cmdline option") for reference.

>         /*
>          * This is the tool's loop. If you want to use as base for your o=
wn tool...
>          * go ahead.
>
> ---
> base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
> change-id: 20261112-rtla-mlock-2a572f10533e
>
> Best regards,
> --
> Daniel Wagner <wagi@monom.org>
>
>

Thanks,

Tomas

