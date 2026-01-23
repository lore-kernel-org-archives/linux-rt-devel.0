Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF71E531
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192151; cv=pass; b=uwBy2YU8WGpL+0oSz+8nUHvNLNmbrujAgC0VPojvl9YnHcVTHdeP04IBq6yavyaCIzDhXPoMUeK0bnYAyf0HxNl2TOMzjqdw98qye7REdNT5UjYh8lWy2WitTCwp+C2HckTaSuAu4kct3MnqRFp2kirg1GW27CTgyZ1hKMGlWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192151; c=relaxed/simple;
	bh=ZpWPNz6SSZ5jF0yhZnfYrdJzJ0WwZC45hMJEFSLxLkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi+7tdg1tKVidaAyWnp1HRyUkf0BIubUjPtYnMnX55IwVsT5vZAxWYA+GWIfH2Bs3Oq8v2N8vPkFTZZXquNEBlwed9oREvibUxOlCX582+zbLemRv7jzKUZ7twB8nbCtSyMFq3b2lC/8kcJcohhUtM4ifpJLkMePojYVDxy7rXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je0aBRJv; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je0aBRJv"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305882so1534772f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 10:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192148; cv=none;
        d=google.com; s=arc-20240605;
        b=aOQg2pssaggLhLBzK0wpHIawPrWkGs2aD2JmUpHppqfwNaOgqcO0WD2rjM2Bx6/loq
         nNoIuPedy34pbEcbPsCOcauEkQkXzGbjj0xvI+a3DCuAKbtIQtw1KPKwbmyJoBjPvZAv
         SbLTOy2BlSEYybcdBnaco+YzYFE03FLZasavQDqv8ptFfaWCJZZGY/mt0acfPiN1ajpO
         3mt08gUEOdrODDh7eko2Mztqjk9twn4qFkRSwLp2YxzUHg/aLlc/LUl5mJQbPyct1xVt
         ZAJT8++EiPfZ4wTp+Zhn6YnaN7mCfJ7dvmK4Zn7/1oesWGo4glnvPD4uxa7igt38kEN/
         TSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        fh=oba1ZnKtDEYzRKL5hLSp+Fznm7mHZ+zpKg6BvVya9V8=;
        b=HnHYgP6z8hO+EnOwSHqv7es7qhU5xO5/da3ogL+MB1+slwk7qlOYpWlbDX3eiQDhjI
         XA6EWqie/x/27vYGSgiBElnSFDtgJ8kB/X6iQC2RvA1rHTiLerlaDQwLTinNXMZAmky5
         NjMb/BY3IFbJSnhogntXfPEyu44XV68YOh9Ra7MkQdsL/+ZWi8k0vMPdbzsQXRXIux2+
         1ThpXN0PNVkVLMbYeitjvZvsBdyX1B/325AnK6d5H0YmwL+HZsha2s4e5PJYeJoFucfE
         pGBldz9jGnQzcbETTndknVX+DQ/8RaaU0xulNe+vwLUAe5Q9r+HLMZRPLehfK6Q2QIgD
         AL8A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192148; x=1769796948; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        b=Je0aBRJvAQ+lursftA0b09n+TIWqHamtU25FZkDZI4q6oK5TMVS3p4n5iPf2GcZXUr
         w2US9Au3fvrUqZGWUzP9BOEUwtw2I1KgWVup5NXpMGDfb1UT7Iz/T9sCThfJPgyLwZL9
         kyNlp7140d829kqqHw9mF8KvTfsDwJgCPQLSOMtWIpdMIt1IEOX5U0aJ/bXjj1vtGk7N
         DVkaDZj7vfXafKayLPyLQZlQIVFI2YVu5cg8M4wx4L5jyHiTnAQs8k2LZSG3Lw8gVigP
         E2VXDLScr24NK4aUHd6/Xh0psU2udVWeE6lHJU5ogwtjB1jPaAHaOB1apkNHSnNLQBzD
         xlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192148; x=1769796948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        b=hZKIhUJiEJZ8aoP1Ko7UwZJTeKzTbR8EEoBr1+3nxzxykAScuYjYpALHkSwXGbZmYY
         ttztG9CWDLHG94eg2WsHRyalOZLh/0iebsCGo3Wl00DqYjDY9CSkYmtCFOunnafRTKKA
         pxzxJ5RUKWhfub+8h5qOdLLvsRPVjz/KyZxCHCtne5XA/0IXeA0OkRnUmRqnOJNeWiSh
         JfSfOGQZQCl9TRkoeavhsjgH5hMv8KYq9dRr/DimRJVhl1UlmjqrLa3kmw7uTcmV3XWO
         d2Jrh+FKzAeyVh3DW4uVDpykkkZVL34NKGnTNAHSW30q0Gvvhh0He6jr0RXB8kA7kDIi
         2j6A==
X-Forwarded-Encrypted: i=1; AJvYcCWr73bHPozfoMAlWW+b/b3iADJjT1VTCQxo6vPWzguLzHaK7X+LAgexp8n5hTJcdrfm5GvARMetRqXVSk9stA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwNGRd+r/EQEZr0t9OdLAiYHJEnV/Rp2BNZS+hfcXozHLchyyH
	qlylOE0sjFF83+GzWVdbbT/BGMRZQz62F+dSxamz3xK4BQwRaNQw2K3nSH1gDp7tdPVdtDessT+
	tYOszOwrNoeBQzMKvuf5NrqqCax0pRJ8=
X-Gm-Gg: AZuq6aIwfq//U08zOznazmpBpy0GGS0CTJClOk7agBN79JnOB6omiCwkbT9PLg3ZoiP
	CThJvW4rR9ozYLZ1RJ++HGbGviXeAM+LIMiWT5bnPSF92Zf1mqlmze/+Y+t02sQqiHYJEsCL9sB
	NAGIl3VoXdnEFhsjRCNlys+n3Pa/DRGlceeVxr2aozw8aAHpWzXYPb1vVAoaAosbAxwHAZgPu1y
	/b2k8ZZTuPecWK2o2vtPLz28yJAPZIrAEFGAx0uJVMem8GgH+TIunY/mYf8u4+ek1VBffvr699h
	oGl59l5u4LU7rKpLzeZWkzwIEoHUw436ML17i8jOnJxLbtFjDMXVpgHMtRVVGp6vKJV6rULp
X-Received: by 2002:a05:6000:607:b0:435:8f88:7226 with SMTP id
 ffacd0b85a97d-435b15fb134mr7443178f8f.40.1769192147696; Fri, 23 Jan 2026
 10:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-13-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-13-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:15:35 -0800
X-Gm-Features: AZwV_QjgW82i1crlpndwrb8M8pt69fP2CoWaYroMilL8QIj30Jgt-nfZQ9Vffac
Message-ID: <CAADnVQLEupQB3O1RzFAPoVvg-frojmjFQhisAUcxTJOmkz02nw@mail.gmail.com>
Subject: Re: [PATCH v4 13/22] slab: remove the do_slab_free() fastpath
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
> We have removed cpu slab usage from allocation paths. Now remove
> do_slab_free() which was freeing objects to the cpu slab when
> the object belonged to it. Instead call __slab_free() directly,
> which was previously the fallback.
>
> This simplifies kfree_nolock() - when freeing to percpu sheaf
> fails, we can call defer_free() directly.
>
> Also remove functions that became unused.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

...

> @@ -6557,7 +6429,12 @@ void kfree_nolock(const void *object)
>                         return;
>         }
>
> -       do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +       /*
> +        * __slab_free() can locklessly cmpxchg16 into a slab, but then i=
t might
> +        * need to take spin_lock for further processing.
> +        * Avoid the complexity and simply add to a deferred list.
> +        */
> +       defer_free(s, x);

We'll re-benchmark this when it lands.
The current defer_free() path due to slab !=3D c->slab is causing
spikes in some of the workloads.
I think with sheaves
slab_nid(slab) =3D=3D numa_mem_id() -> free_to_pcs()
path should be exercised a lot more often and fall back to defer_free()
should be rare.
Just leaving a mental note.

Acked-by: Alexei Starovoitov <ast@kernel.org>
