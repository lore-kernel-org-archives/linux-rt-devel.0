Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BE26F2BF
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Oct 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554350; cv=none; b=N+5bLR86fu1l1CpZSn7f/05dQOxS6ZIvrs7ze2/Gf/4cxxb7GaNjfheH+xBIS2jxOSEh2eANPzZ6xynw21bhIpXT9O62uj35fe7pxcUSYKN/hAKpimhXCs9phgMzlG2q6vXf3VvavE1OjZcG77GaRzNVvoUM/BI4242iZmlW/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554350; c=relaxed/simple;
	bh=7GoMMvf2/sMmCp2L8Hu2JxU0jx5KsMajr3k3t+243Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJica2O5v31GHpB82nfBpXn0JMgSrI7rr2Lldg9DbvwURMq22bXrjuGrbRpA69P9/D0oc59/gxw1DzVftHnSpY9a32OJLH+vZthvPc+6Ditc6glETKZcEpVfHb+2ANoQdyl1f22MqzgNX4DbGLG/CCAm8KZTrNPQ2VfiRN1UoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPr2cZTb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPr2cZTb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46f53f88e0bso40907705e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Oct 2025 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760554347; x=1761159147; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwQCNOMiVNhviDLYmWNQR++Wsx+PX0Dsjg6jZ0iSZ8c=;
        b=gPr2cZTbVqoavd6ULboHJJUoD/x4McQNeypH8zRwhkk15uGAbya1Jh5kyZU10cEH0y
         jhGbXMVF2p4yLQtjg0KZGtlmIMrJ8CGUZOJwPIET/MlHnIj+8rkr9mxuaTaFPXqGI1hO
         mpI64UvMNeXm3ZvAGi1I3UA6ovQ/8wy1nhepxQafiWXQYbtXIevWm27UCpv3TxJFDZt2
         V3FG8h7XOloeq3tcBYBmUJ3aFeDR6yPnSEq4p0aWYvpNOcx266McCW8Jf7F+g8UDcgJ6
         kst2Srj/yKJhfdgdTtv6dScqYRVuoLep3pM+HL2c8JFO1PMcHaYMkkCCxKu8hLS7G/57
         83rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554347; x=1761159147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwQCNOMiVNhviDLYmWNQR++Wsx+PX0Dsjg6jZ0iSZ8c=;
        b=SSdG9IStrNjEjkblsIY/iYZOkjC+AQEHNoOAaWmrGk46iZ93l7yfUG3or170Qt5DBo
         MfU+jYbn6oV2MewZLoHjiBKGqpcXE7RDMn2Mbtio3DqNeY4l+rmsIYHhoLEaJNuk0bYj
         jc0fUVBqdHVAV9ydZhL3oAJZb0/AR5kv1lFoAtgB6VBc+sRwUznNRZ/j2K6vZ/f6J+I9
         m9b7gn9s2yoApucXnrpjf76YZxmM8ZRYrGrMg9eGmpcaN91OxP8/pgrSPFKtHQU+x5lx
         dpCtF/07VSerWYT7cUQtmF3yzoTEFsvJGB2dIoi2JtxLrDw4tnOF/Mr4gzKmBgkPR8Sy
         dxAg==
X-Forwarded-Encrypted: i=1; AJvYcCWwdSKipuqGVNCsszm04VOyZ1mC221Es0+bPTQkol7Kp+Bdfj6Ny2yXrOshuCo869LbkdGeR2Apx6IMeZDhkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvYjX9OOLPGwr28sVqe1DHK7rFUrxQRE4nEFMbfZZ0dvTMO6U8
	WWLwlKWmJLPgLiuuHTHxwNGdV5pAYJgvmKwfUCMhhg/Dl04CZTj98hK8
X-Gm-Gg: ASbGncshMjuRCgtlaUGz4OJtAQzQx4P+B+yYbrlCUMLnAXuAQ6PjmCXiJkP97ZTzem3
	c+PgBinUIEJCKjkB2GiPktO1BRcRMHPuLH1f9EgVEboctn2pc7jm4o9lPpOQwL/zC7shi4Etx/Y
	H2w6OE0U2DzZ4pGqo6LZikmRZU/peErtDycmNa1hOOxHdlwDn54hRSynEPuz7XlGVIH3epkipbu
	bZ8hd00dlsZzz6UsDBCxt+K38FecVSAo7zVzxXvz3e3YCC0OXF/gp/GRPd/1KHPNCApkfwqAkHR
	eShbh8Q9CVUhimHcefo8IBTd/pc/Q+xG+udj4fvtfzI2qxNZOrWLhb4pB/ZM3CUbOFn8qSvBGXr
	8AQxkXtxye20XJdeITz3sP4qm9UU9j9aEeHX2G8NizFeiSQ==
X-Google-Smtp-Source: AGHT+IFfn9/XhYNsg9kEBy3HRPWyVtIjr2aUR9s4v6atPJEbesiw2bkGCZdPCRugezv9LVZwavljTA==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id 5b1f17b1804b1-46fa9b08bd7mr240557805e9.32.1760554347187;
        Wed, 15 Oct 2025 11:52:27 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3desm30688069f8f.7.2025.10.15.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:52:26 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:52:24 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Message-ID: <aO_taH9CKxmJPnhV@fedora>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>

On Tue, Oct 14, 2025 at 02:17:23PM +0200, Thomas Weiﬂschuh wrote:
> The documentation of that function promises to never sleep.
> However on PREEMPT_RT a spinlock_t might in fact sleep.
> 
> Reword the documentation so users can predict its behavior better.
> 
> mempool could also replace spinlock_t with raw_spinlock_t which doesn't
> sleep even on PREEMPT_RT but that would take away the improved
> preemptibility of sleeping locks.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  mm/mempool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 1c38e873e546fadcc594f041874eb42774e3df16..cceb09b75ebe35f263a5fb95ff6d400221ecbdd5 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
>   *             mempool_create().
>   *
>   * This function is similar to mempool_alloc, but it only attempts allocating
> - * an element from the preallocated elements. It does not sleep and immediately
> - * returns if no preallocated elements are available.
> + * an element from the preallocated elements. It only takes a single spinlock_t

Might it make more sense to say "It may sleep" instead of "takes a
single spinlock_t"?

I feel like the fact that we take a spinlock isn't the important part
here (especially because we always drop it before returning).

> + * and immediately returns if no preallocated elements are available.
>   *
>   * Return: pointer to the allocated element or %NULL if no elements are
>   * available.
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251014-mempool-doc-625dd4996110
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
