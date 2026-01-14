Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790215E5DC
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361485; cv=none; b=GLx5Wdu0MZ2t3Xz+U0hM+KRhU3cD5yS4F5+jSm0JuuyUGZXviWCihHj+OJxt5bCnZtTfvxLk5UmJ6rj1Y1Arpjivl4DIY5HZ1GyECV6EZztSRW5jcLaceC5pENXddlWPEax91wai2OHMyxcavjMl4L1iKx0N/vj9BpSfsIitxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361485; c=relaxed/simple;
	bh=cfrqsW8sP5o7ktsIS6ZHNgJ7VMmSDGubBh2uclhq+J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3c+xp/BuhrT/pDrncGV1GIWie9+uSNnA8Ybl2AyFI/H7iofRyYEVExGjru0wAr05VER2cw92s2mbj42Lfkubrb/t4EBye9R4NMhw4zX8nh43szw3sJQVOq5fxABZ3EpwZLYDBcC9jGpfN3U/FgAvv+cVihKjlXvOT0718PHcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGZPW8jU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGZPW8jU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ed9b04365so9370785e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 19:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768361482; x=1768966282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAwkswLSDvceXj/iX0pI2u7qJO+mp3M2B3KW95gBNSc=;
        b=FGZPW8jUXZY6sQOMoTFE7mYWwG0fdkTk8sMqVkCME8pEDUxhJG4s4tGjhOHRvDDsXM
         XnRiobk291Q9K61rjaNPE+kjS0fxvWiNHF03bJqll4+NsAe4flI+BhCGqSJy5Vbtgqt4
         iuk//eTcskxJBpsF0H1OQC8mFCQ5Uz0hB9nW9nEceqGAL1OBfUGCx5w5wV8sI3HwAAs2
         jKqh0+69p5XX5Uk7V1Rp+ZctsW1CwFeV6J0Nm2US07eKZvpLpDgNoEUOSBFWJTry8kmI
         lRrYOQf2RcfOubiQlFeenwGU4azTMIn/R4CrCT2TNhwGyW7C0RP8XQLEfWNAEweUFnpw
         RyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768361483; x=1768966283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAwkswLSDvceXj/iX0pI2u7qJO+mp3M2B3KW95gBNSc=;
        b=tMWHtXVAUASVAMyId+2liroTmOU2EM+xihGF9gFKzs6XR2/vx2frchyOhmVa9TSgBD
         x55/bQTHYfTSSpP+LqMGFgrpmYAZWK0IBQ78jjy4+7zH28+CLgwMzLs84A0On5ieZAeY
         82f3Ry2Uvu7l0U5u+3N0gVGW9tgFnQUQMrdhTuvVwVvxwCYq0+dFRQIOpi+EljH1IL17
         lF7cgQQGTxn1mL8XtQosmFTQ2Q+AnVaFfPZMKNuui3gTmlHkS+RREiDVGwFU1iBEPeBN
         t23RUzQ/R1Zsp48rTVreXWHWJ2GT+JAV/d9O7JpBy3tc1E7mO6WPh3aXMF/1PMiuH58j
         OAbA==
X-Forwarded-Encrypted: i=1; AJvYcCV3l6SxWPlpj59umonF/ou0AcVq7Nyjuu5MwFv3iCQ2G27pIKwhPOUSk/pGnANn0u2Q4+fa6KM/ffz3uqmmIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/doBzP+d12cAelV0PXfLxn+jls0nddh7pSRjO/qYLa6p1RLgE
	EUerYN3jG/OpPVEuXkvoqNKubydTxW/HUpA1+9QTEduqK4aSSeQTogtHIN4UZU63cGj8i64VYxZ
	xaZ/OPGe9/HVMMNSaeCwsFqm7ta9GJqQ=
X-Gm-Gg: AY/fxX6n6IzxN2r1Hb5urqC5xgPADJDn8JZtTv2rZuBs3vfQ8T1ZS9iB1o1e/MRvMJV
	F+0o6+g4jAmN/m/zQayf1FQ7J0F6nQIwhDCoVER0bVlIID8vZxk1m4m1PXNVALQ/jrUUYRyT1QP
	k615gx7tXDJXaO85M92uQjTq4x/VDwLGXuXov68GRi61jFOyfqX03m6K/QkBGCGVVns82DkQOD6
	kZS/pc9s6EUCaFBisstNVQgIrMscQ/yN631Sqf7F8oCwZWuMeQmBdlQwfDSH1zRmRsFgVvujTXK
	IxZtPxHJn5YnoCzSV4MZs5X3hkHI
X-Received: by 2002:a05:6000:310c:b0:430:fc63:8c8 with SMTP id
 ffacd0b85a97d-4342c54759dmr1005118f8f.35.1768361482534; Tue, 13 Jan 2026
 19:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-13-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-13-98225cfb50cf@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 19:31:11 -0800
X-Gm-Features: AZwV_QjU8IHt4ADtGwZuCMWdsEN668TGd1jbbhsvRKh-PS7J4GcDNvMn4EbhZYo
Message-ID: <CAADnVQKBt2xmqs+o0onUwd7G-0UDbE8LECnkJJUCVbywAr2tUg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 13/20] slab: simplify kmalloc_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The kmalloc_nolock() implementation has several complications and
> restrictions due to SLUB's cpu slab locking, lockless fastpath and
> PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> things:
>
> - the local_lock_cpu_slab() macros became unused, remove them
>
> - we no longer need to set up lockdep classes on PREEMPT_RT
>
> - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
>   since there's no lockless cpu freelist manipulation anymore
>
> - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
>   unconditionally. It can also no longer return EBUSY. But trylock
>   failures can still happen so retry with the larger bucket if the
>   allocation fails for any reason.
>
> Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> slab freelist, and the alternative is slab_lock() which can be
> interrupted by a nmi. Clarify the comment to mention it specifically.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

sheaves and corresponding simplification of nolock() logic
in patches 11,12,13 look very promising to me.

Acked-by: Alexei Starovoitov <ast@kernel.org>
