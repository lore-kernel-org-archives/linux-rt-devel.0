Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F56226CFE
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191563; cv=pass; b=lxO9JDZ9SZLPUqXo4OOxlH4Xe9YdeHHEcFCFqc9KM3Pkay2oY1XRgUr76e4pbRgFGhGdkYy0OjCFK/bKBG/3LNGy+aorp7kktrkrzo7yJ74ogl4c77ZLvxATuzXw0EKzKaGtqM/oKKrH3p7qQ9Y269Dl+Y7MEpsZzPV6IvFX4r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191563; c=relaxed/simple;
	bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyZO2ACnGNrto0X1bkfViyvh4yKpFNGL2CXMqISzHcth27Qm07aBtLp7uZh2q7wRhedS++1S82gWS0mmXGDp5V7C+8Luo/a7ezM6ZxuHkRQ3dfhMnSKOppvELlXZyUA8pc3OYUIGZoCmCfLxCK9ZOxcEVcPm9srJ7g1Lp9DtvJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONC36iKW; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONC36iKW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so34505705e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 10:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769191560; cv=none;
        d=google.com; s=arc-20240605;
        b=SkimfpMTO6xmrxTbWFW3hYzwNlkGZ8KFfIPi8HjMYgRwZYk97KtqInV/0ROEjdIdIZ
         p+EUuUdjcQvfQERM3WYrzEYauxs//Ba3kLiNov4DtRjzui/zddDUhJ2FwKZMSzmxyDap
         7Ben+SGb+61n8173AZYVFRv9mzawxOmUXsLqBI82ShG4ybN6ePwFtHMutmab51+gwjmg
         yGnk3FbMkYg9ESP89AAGueG6ulsLIzLAda2x4fUvnwOXMoQVlJwqxxqSxqsLUcpIkdQE
         z5Hw1Br1i8Cwdn3WstiUvp5UjaxRznQNOj1TX1rIw8NkrQOOl6givq4iEOsYa/fQBMfd
         FWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        fh=3CKV9wlpQJ3jBoBjKAGMWBs1Wr7TAcwPf0zO6jc3yqc=;
        b=G1j6TOsJYFE8n/mP1Rx0LxSldKL4BwqZ4nVG4RTfqy71vDYd8YE4QwEsVjF2D/ZimK
         rX+4WXuKH7cgOCzG3VlTe7TDpYcT9A7rk1aTA9v2QoiI85rVy8os64pblc+g/jtcuUYm
         L6q9/TlKsqGO68gNt5kk2OdYp0AgD8SlUuhiLPtDCbZ1035FFL7luo31BqsladRvQZ/Z
         6fnYeNoWnqEZXOlsseatDW1qTu0UnM/nGXPoDrbVJAh2l6S69GY3ioUA8xOXTZSf7SZV
         3BRy5BrFxaL2zew2jourHx+u6KpBZFcBJNy3/MYYExkDN+29Z1d/ctcMpBD8JZfyqfH3
         fZag==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769191560; x=1769796360; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        b=ONC36iKW0K1zKOoqr3iZPzfQRQ9Jiwn83qzhw6rhLLzUIHqNiRAVwpzd9UifAd0e3O
         ivMUsImtLWcf89z0rMdP/EOshYDj32vZhTtTX66MeRESzdkN73O7uBqmu52BOnglM3iY
         EmvfilBDnJ2fNNNTmCKSy6X7B3Ytr5VYRT2Ic2f06Z/qUS43ndG57zZn810sjPucDCP5
         86EygTefMTrLB9P7MogX43ySlXActN1WhILjzG4l/qw5ihcePZnZ7iayzxzDx1UWjGl0
         0Ao+9EfY64gpKghapUK4RtfmlzIRgPo/EZPCy+ygzn5i7WDqcIZyNhKStKWSXb2GSHyh
         NAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191560; x=1769796360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        b=uyhAjH8P/erp68J/y+jr3uOWxXshlsjqzrInMKr4AAWyNbaALkAN4l4I5vbuNtl32J
         LTfd0WT8SGXK4B6NSL4d+xUlJo/U6r2jbqYQ1t5u1ac470iWAkXM0wh+Iu4DR5VU6vcx
         rICJo6bLnF1YyIq0kVBrDiFWdgs8LoKxu6Vq5UeEKtlelSR2aya1UZn1VPHSGheCw/Sr
         yDOmxtpzT4RkX0w4nvEsKqufZA1Dshw82fHv8GLkdFQ6cSEk9tOWMrLu5ecRS249bFXF
         6lbqitskyQWic3Z8U4ZA2s64Z091PrMWINCeE5oVRAsbhDNiLT+wLnVf61V6CEXW9ztB
         nPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKOxg8kcvEgMp+mvHCgfbLo2qLP4r4YEUAvMF/dn8m6z9nuapmw+BZ/e7iKnoWizTojL8Tf6nBLR0FS0vqrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrtlfoVm/TCr5DQm2HFRMzGhmwwphMs3Wcimu6LQ3B8EvX+OCS
	ouyO0AKRFoP2i/tlq0T+zRC1ulJbF1mPJkiht145qk7vAbUaH3qzaW0X3BCgeJZovXLIUHyZGfz
	lV62NjwaO2nXMtOvjLMDobMinBt45gxI=
X-Gm-Gg: AZuq6aI1BBds+j1zT5mrjEaCTYRPz5187efygsoYH5LlG8rtNpaB1BX/X1CGZvzBKOK
	O5bB0c+yCzYfW11fJOLjDJb+yS8JGLhNwSIKV/UYrcH4nqiNXYFwLfJhluYqAKXAdKte4N5VJiH
	UZ0Mt0yFjKyjWOWGVE8xlWIl7PRa2jnWJznlKMmLA1Ujrwn/xlZbE6zczmhJXSZASt3SGG6cFHK
	3yw/JFlOmRBSE/kOEN/rxjBcM5yZaWCDBcOYOoyx/bYJutf1FExnNbePtgyNS7nJ9xtiDtFfaxV
	bFM3LyGP+cZdARNr66f5q6uhoKpyqV/+KYcPq/UoSGAEozip4ehpDdSkeTiI66mQpWL0OHwo
X-Received: by 2002:a05:600c:621a:b0:47e:e076:c7a2 with SMTP id
 5b1f17b1804b1-4804c95e12dmr71414205e9.15.1769191560210; Fri, 23 Jan 2026
 10:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-8-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-8-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:05:48 -0800
X-Gm-Features: AZwV_QjSjoenDUCyXmvsb5KH8Pd0BwP5NV53NJnMQ1RHDoaNt4mnnL7gEc0SK7E
Message-ID: <CAADnVQKW2Z62+xC5NUsx4ynqbwPh5yn_EJJrQ4kcPab6KWUK-A@mail.gmail.com>
Subject: Re: [PATCH v4 08/22] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
>
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
>
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Alexei Starovoitov <ast@kernel.org>
