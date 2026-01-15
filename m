Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF21320A1A
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521136; cv=pass; b=kXM6rM/FyuMGghaPA3JEsOWKGJJFQAnpk74vBvtmT/7gINXcBqI8Y8gYu/96SI8VSnl+qnrbdWcca0gLwcIlIdty9vYvj2FmPZB+BtFARVspAzJbUWnOBQ8UWy7i2sEU9qFCZKpPU6CuVaFFnZ1Ew7LIUze1h4HixvHJw3LsfOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521136; c=relaxed/simple;
	bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcJnh5mgkAwdJ9EVnN5mGVkjd+KHrln1YLbrk5kQ6Xd4u9wfWv1yCSEHpiy77zxMiHWUGEPvBaAkmyeC1hIKFd3HJ2RqI4clqcsZBGe91mCRGFX4Q4F4tVc3FXGGnl4wUOsjqLhvbyUJA85Wp/LKjKXrYgDLRxXWfoYJ+3qVgCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdlu1sL9; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdlu1sL9"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50299648ae9so91811cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 15:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768521134; cv=none;
        d=google.com; s=arc-20240605;
        b=jXMllhWhiARQWd9I5robKsumhAlIvpGjeUpc8gCndlIwMdJiJ9jbvhYqba6hDYUg9H
         P6jI1s+7d7p9++oUF+Gj4O0Gv+oYyZ1bxaI+kmjDa4lEC0OpxsZgYb84+SO6a+0HzKrl
         uv545nBqO8yQ4CYIpJAf6UQD5ZtfGcHvxys1Ys+rvdPzoNfDqIZjMA9yLTgRp8VKSmPH
         +H7Iwq9FVPsnaC7uGWI1vqT3NQzDdpiPTd3KEkGWUbMID+oWI8xUoioEYrp3t4mm3N2O
         nP60CpspziMO5eJuf9if8T67BM/aIvdOupVWnYH+CndAXi/gydwHMArxi6A9eWKPHbwN
         Wpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        fh=o8Td3BwHZ8yzoHHML3xDwek5KT14I80WvudpHg4fwtc=;
        b=ktLMXK5ufKBBNcRU3U3QTTkWecRWns7Xbmawlh9nX+5EvI/xJJvWVJ+exziNezUYB1
         hlR5f8DOyv1blpq7/+SwuTJRVqhSmD/6UkFaQmV8C0e9lYDTb8E++mE1unonNjsoheNp
         vb/reoYvaI1Z9L2KdH4M4HlFBDlMBFCwmE4j4C1Y2mKonEqy31E7K1oQXhFV57L3ePlJ
         umeez+tftjwRfUXoLeWlhtvEO715dZ5mKH1obJKVf/qbxJnbYr6HR/yJZQJ5avH3sVZQ
         Gd9t0RbiZb0DrS85NOimYoxtnL1sinv5trUIHW6LAJC2iVQN+tEefZrY+x6yhCQ+y1vV
         Leeg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768521134; x=1769125934; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=bdlu1sL9GlOtRSR14P/jk47nR+rAj6wargJ2nkjXYw0KAu7P3UDa2SfUE1pIWQ/Blz
         Roi5Nl9fEN2PL5jDibE+XS5exATwak0VHtlL6VSA1pVEmozaDkhJ6ZAlEYN4Nag94WC4
         02C4xlxo9WhT7668LmkNlDRGe6AYft6WDDBdTebNZClL/mvB2+X4txpjTZHgCFt6Hrlf
         y4ueV+BIwe79S5UCDHrFQ/Gbp3TzSuQUX+2taXlyMDK53jCsRy5PObPY0n5H9nXWn4Jr
         O91L9Cfymnvy4969oGKDiQedkk+CJLO3c6/noGipsqSOTGgAPTyCD+sANHrTQFdpABD1
         QJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521134; x=1769125934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=KaslCvEoB7J8j4avevO+HqaMTAxmFV7wcULcESmHnDjyHhqyaPdlpx8YRjvlXO/P01
         Y71xRaaOqhmtSkV4iG1Lm6Z/ezl+6nKQxpYByrjD6aoT6p1lP846lTPbbvk/MAU8gJ4t
         cE5x2FhRgSRJNoPLWsn3Zb6w0TBtIMZ65ZpEIDw8SmuUjQExS95EKjlFGuuMVacORpR0
         dCWheCSJuxn4MKudoNjj7pOUQFw2qEXz2aLfv9eN4bpbeyY4zT24mhUTCxOlaAkMJvXq
         aWHUw6r5lD7EwT7wysA4NAh+TJFx3fZHhokjgzQuVK4DRi2bDmc/styCnjaBGF0NQ/XR
         CZKw==
X-Forwarded-Encrypted: i=1; AJvYcCWO9edFx8fQA0yooIOru988sOnjKoM5Ekooq1ZzMYX/okg5LZX7pMlvg9+TF8diKSApyEJkr8v2T8TWMgiAWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBZpQATShPMcky/IrdkzFnN7vAzlYZlIl0UmMb+rxjix1ANNnP
	Xg0ts/mUTw8gkw81wyqbIZdhkfkt2ZJevfAdgNiDXT7hOktoYCFP/GQwx5OE3HiK7ucOAD9Kgw0
	VA7v2uBNb231K8GV6/h1zANfiHGHna/TlRToNuZ31
X-Gm-Gg: AY/fxX5m7oOCkpzLQhpFJMgs0zCw4PuWlMLrdiC5j3TioGBMowGLCmk35IqasN8/UzL
	bHrZ6Rm/glbEVWTzCsbL/JXFR975XUYyrho589j19bygeNhbtZzw3qWnaUlSjfNix/3UqXQanRb
	ZfGpDfm71eKW3yGXahhxKsWjsWKg6+a4QU044pzYoXBYpYgCRAd4rr2OwB97gErp8TnRLOhnf+J
	S5n+y9w6SusmPKRPui85+JBDHshHnaH71etOHNV7Rw8cacV2rADOrPIb2VHZ3jcrC/i4XZS/FEE
	GpWvHWrF1UYBgZmCOh93KK+W3SxG99DnWQ==
X-Received: by 2002:a05:622a:58b:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-502a22cfe86mr4096151cf.2.1768521133130; Thu, 15 Jan 2026
 15:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz> <aWWpE-7R1eBF458i@hyeyoo>
 <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz> <aWY7K0SmNsW1O3mv@hyeyoo>
 <342a2a8f-43ee-4eff-a062-6d325faa8899@suse.cz> <aWd6f3jERlrB5yeF@hyeyoo> <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
In-Reply-To: <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Jan 2026 23:52:01 +0000
X-Gm-Features: AZwV_QjyQPPUtH5tGDbHEFhedU3kKqiqu-2QyYB5WPZJAwFL9F8l2hS-k58cSQU
Message-ID: <CAJuCfpHCgyKTiPOZ_p76hTLRrZfQrkNh7XHJkEM0omWWCK2WQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com, kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:02=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/14/26 12:14, Harry Yoo wrote:
> > For the record, an accurate analysis of the problem (as discussed
> > off-list):
> >
> > It turns out the object freed by sheaf_flush_unused() was in KASAN
> > percpu quarantine list (confirmed by dumping the list) by the time
> > __kmem_cache_shutdown() returns an error.
> >
> > Quarantined objects are supposed to be flushed by kasan_cache_shutdown(=
),
> > but things go wrong if the rcu callback (rcu_free_sheaf_nobarn()) is
> > processed after kasan_cache_shutdown() finishes.
> >
> > That's why rcu_barrier() in __kmem_cache_shutdown() didn't help,
> > because it's called after kasan_cache_shutdown().
> >
> > Calling rcu_barrier() in kvfree_rcu_barrier_on_cache() guarantees
> > that it'll be added to the quarantine list before kasan_cache_shutdown(=
)
> > is called. So it's a valid fix!
>
> Thanks a lot! Will incorporate to commit log.
> This being KASAN-only means further reducing the urgency.

Thanks for the detailed explanation!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
