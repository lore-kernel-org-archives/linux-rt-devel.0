Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF71DF256
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 May 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642773; cv=none; b=SMYMqMMMVV7oAzxa65G/ECSeoEncYoYZRfgCsU/Ea+30PlLPAEZnaui2q/MVPKKlf6oWhAPUy8p7lqgTObgQA6XBznJHzA6M3nXnt0AELvS1qWIo4DOqoc/8IBKr3DT4j6r4CeJ9Mop+B+qQG+l+X0P5HmLCeWDILayASSqXVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642773; c=relaxed/simple;
	bh=qHrNfjhkTdPxv7dsNvqIcEBZLFpkwwu2nyoz5CcYN5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXmxSsBSVd+ogghLn0cJ41kVw81HHmk3keP9qPm+h9n2qiEsv4JOqwZhN9HE5IO3DDXAQ/a27qs3OEC7vPXdTeDuU4COw/keXfUwjbLPmqOEQIwVcBeZhpEQbTrEwpZZq+bcqE8ReP1HAld+0mx2btalq2ByNQSrjq50MxPEVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+AsV6gw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+AsV6gw"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70cb334de0cso17864887b3.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 May 2025 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747642770; x=1748247570; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8T5GaC00Oh6pbsT/dB6kXpfiF0+p4YxQBaiUBsDJs9s=;
        b=O+AsV6gwg0Qf7GdXc0poDVUWKKEVr0eDK5QurCbkFvo1kb8IXKjbxfRF0WCPV9gk3l
         7HE7PleOTfyRWrUpr6Nm3wOV+u+eyU1ZkdVrbFCpr3VtXhfnarBChnSeZmi8PFjFv1q+
         4x9zkrPRfhyvrca6Oyxt7/Boyy1vC0wZy4RdOxxBmUnCrW34+Jcy37VKt9F9dhGNDbjq
         ozBuUjGxQbCm/vNPGndUjUxlcoxrRFBieD1FL33ZhWW3XdyC4Cgp/e2/ecX7cvtxX4yE
         fd9RmO30fP8hpRXmSR3rmoTPGPwBS5kfxnePsun19MO3lmqGp5BHSRRJTr3tzRddBY90
         MfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642770; x=1748247570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T5GaC00Oh6pbsT/dB6kXpfiF0+p4YxQBaiUBsDJs9s=;
        b=VQntTtq+pkievw9S4sCeBqeUvtKZxDhSKZKtm2suyfFY+jkRN/6jUeBcwytglM0wW7
         iO0n6eVXjwjtqSguljkjbvjP3FNMSHEXZcIOUB4hoagFC9plWn32t9rAJ3v2tmIXeY3M
         rc5SbDQXtwLfuiKtXhC8VHTkRHHyjBVktbc4ZXi3VRkql3682gNowCyO35bzlPuiLuq7
         Eug4g/TYkhjZc+JNfKpYT5WkQhzi4MdWFeA9ynwqHNZ6GoI7xV9+LkJxLg347zRpe1F6
         04xy+vaZLsyCMQnaiGstPcXXPENjmkxB/cGuxqJ2VmIEGQxitloI69Lu7PTZMMQhEb6y
         LGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQwQ2TecjHBkBDnwX53k3h9ahU6ouHzAVGtAQOZVVUHd6jBt9VpjI1M0GloXu8dWlVmE/7OkhRH3s0h4AicQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycR4XqDtRX+R4QW1x8+nGO4JFzF6/CHU9sNQaA5wFvOsxbwBU0
	meS2oLdJlr/bv3lwc9LYGv75qq5cr6pL1TxRdeKqN5+R1Da9YPhFrr5E5Mwj2+5ZeZv0Jk7HYxM
	fd8AgPkhd/gEqV79sUyGDbJP1rqlXeEfIFAHb5CMzng==
X-Gm-Gg: ASbGncukSuVHJEYCIicwtYZb9TrLPiWNii9f4Z0tSwpftssHHBF4IrNDAzGFuzFQuXc
	nejH3ZlWreDeiwhYNHnGwOMTGGUTXAtFJnXAxi65JdaZHkwe1JGsXLNNY5shqOewSA86qA9nEYu
	l4rxc0MJPacr6KkdOaeqQXE8a9PDPltkJ1HtQoH3IBURJJ
X-Google-Smtp-Source: AGHT+IHVZEKHlEswOX5OCc1QRZakfm90tzT12Po7rI2xlHzceNCuiSGkBBA1efBixR4l+M9gq6fh9RiwtFmBEo54yDs=
X-Received: by 2002:a05:690c:25ca:b0:70c:cbef:df24 with SMTP id
 00721157ae682-70ccbefe213mr56246447b3.18.1747642770378; Mon, 19 May 2025
 01:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250430124758.1159480-1-bigeasy@linutronix.de> <20250430124758.1159480-2-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-2-bigeasy@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 11:18:54 +0300
X-Gm-Features: AX0GCFtwBsLFjXBd32Ez6uitmmBx_lBhripiRgNhztcC93mzeZogx-11fGgxn3Y
Message-ID: <CAC_iWjLwssHzyn83XO_XJV8kYBbz76NOsSE2cT90aKPzGLu8aw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/18] net: page_pool: Don't recycle into
 cache on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian

On Wed, 30 Apr 2025 at 15:48, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> With preemptible softirq and no per-CPU locking in local_bh_disable() on
> PREEMPT_RT the consumer can be preempted while a skb is returned.
>
> Avoid the race by disabling the recycle into the cache on PREEMPT_RT.

I am not expert on PREEMPT_RT, but this sounds reasonable.
Did you have time to test this at all? There's a kernel module Jesper
originally authored to track regressions, which unfortunately isn't
upstreamed yet [0].
Any chance you can quickly spin it to get some numbers?

[0] https://lore.kernel.org/netdev/20250309084118.3080950-1-almasrymina@google.com/

Cheers
/Ilias
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/page_pool.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7745ad924ae2d..ba8803c2c0b20 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -805,6 +805,10 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>         const struct napi_struct *napi;
>         u32 cpuid;
>
> +       /* On PREEMPT_RT the softirq can be preempted by the consumer */
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +               return false;
> +
>         if (unlikely(!in_softirq()))
>                 return false;
>
> --
> 2.49.0
>
