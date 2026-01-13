Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397C35BDDF
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346827; cv=none; b=AqV5frHlRFmCmi9ciIrhzXMnAUdCqcWY/2abY1yawahe4A8ZnIvXNkUhMnLCxJrPG8dDXwtrtBd0E4s9TckWhBtKfU3FdwFhOEYVK/Fr3fJiEFQ5nS4jXQHpEPk2CVsJSe+CuxvDCjkR+j/hwsb/A/wifmyKAWbD3om0es0LrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346827; c=relaxed/simple;
	bh=PQjxtvb69+p85Hb04eIo6x789En0DT9HhMnHggq9OYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stgbKVy2fGM2z/dBeHqeXdRMnxFW3dfu2CzZqn4uJbqzznfuCmSM/81XbYw63l98+WJZRBBT9B+o+kK/JZCNQwa0evPNwZb/TljWIweRurhheJKI2A81cR/LUk3sTxYYmTIDxlPWUjL32swtyYT3yy9spyaHE57DwegXL38JaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITPINgx+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITPINgx+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430fbb6012bso6495430f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768346824; x=1768951624; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIxHGmAm1SZZrcYdW9mVCY8ENSWv9Idzn4C9R7aSfY4=;
        b=ITPINgx+OnrY0dORpzegRV3X/B5s/mLt2NldDXnxbisDJNAciwbzhwSYlKucYPbLi8
         lY+J/EJGqyJ6fYbhy2goSflDwXXA34GPDMeoPVKXlJOZ1ilc+q543A6UOD8OlKyEkT79
         D0wCtT03/c3b5SABIp7yuv4tPoM4PkUjGajVuTDsaN/hMj7oU2n4lKfChF6t78m1k8rA
         adtz0JT3/zDJUHAMjb0KoRxQ9ouAVXFANwCART3K9GCWfn1pYGHhjg9Izsxo1NjdF7zp
         fY7FlQCiT9ow37gfrkGLY3jiMF59uS77/zXsDJrudgVH5wSrUJGnXReQkqg0RMbEQoCn
         dKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346824; x=1768951624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIxHGmAm1SZZrcYdW9mVCY8ENSWv9Idzn4C9R7aSfY4=;
        b=SanODiF51eg8NlbI7s9he2KM2jWus6iJCGRaejcScqLKg3AifGVxqxfRjnkUKsH6sf
         LBPP7qKpjvrWO9e9QMgQlfZVTH7wnjdXxbWSMLHFs/4fY5Zg7wfBy66x77zMujiV3uTe
         +tSyzOfyasZiBTcfbvdBwqe+rEtmMShSLJAxgYwYhgYNjue0iLCN1Pquih+Ea8i3gLlM
         y7Q38iX047lSk9Aolnp+LJMV1/CrIHwFw7cVeuBB3ZQDpK6RVqAwca6PfLk0WrSDsqC/
         RfZLmKmIgYPtIuU4rZenC04Gi5C4TL9cpgWlUt3ik9Kw+d+NYnMB3ChEBcqujIGtX2ZV
         enbw==
X-Forwarded-Encrypted: i=1; AJvYcCWl0cKlhESfvkdSpemGVYm0RthDrnoNWAif/u/9DlHkvq02yVZrZ9e0TUSx4+9BRfINzam26tyGgGCBwWX32w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUiJ7sn+HLXV+Spt3z/FLHQ3e3ARNCGfVWXKFW/W+RdmnF4csF
	LmG8glsixhRAIFK2jRRE7ItPxlQUa4raxgltFdrAWyDR8JmVtNJlA+yQKadsbUOjgxB6ZRAsXTI
	PtjEgyUIT15ZDVe7xzFg6AZnpo94g22w=
X-Gm-Gg: AY/fxX4YzI5R2ZSpKl5mXgc2d33QoRjhUCD8hFfxdWlvHG4gRCp4mS3qsyOCc6nVkEO
	37CD857YACL9elbtxU73G4WKIQZsPM8eue7pafZ/4yzfp3lzYMNQNX/zNWD6ZHip93WUG/cxJza
	1apJiOhRqalefGNRGzIKvz+GX6UsVtkZI3mh9oWbufD0laZzCOBBNxtwkwZc+2Hs6RM/U1rNTbv
	mxTWMt5qTDCMwm/Xm3JE1Mn1CLvvOEf7GR6j7TK9pnqvvrM/boj+wD6ZWcMgbBhuz3KShxeALJp
	tDEIOpbGDqrogqtZEkiQFux6rC2G
X-Received: by 2002:a5d:64c5:0:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-4342c501a57mr685880f8f.26.1768346824132; Tue, 13 Jan 2026
 15:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz> <20260113183604.ykHFYvV2@linutronix.de>
In-Reply-To: <20260113183604.ykHFYvV2@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:26:53 -0800
X-Gm-Features: AZwV_Qg0xd2SuSeZtzkfObEmnG4DkzskoYODoJFcrxj4bx-h7Wvm-bafCffVqCQ
Message-ID: <CAADnVQK0Y2ha--EndLUfk_7n8na9CfnTpvqPMYbH07+MTJ9UpA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/20] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:36=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-12 16:17:00 [+0100], Vlastimil Babka wrote:
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5727,6 +5742,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t g=
fp_flags, int node)
> >                */
> >               return NULL;
> >
> > +     ret =3D alloc_from_pcs(s, alloc_gfp, node);
> > +     if (ret)
> > +             goto success;
>
> I'm sorry if I am slow but this actually should actually allow
> kmalloc_nolock() allocations on PREEMPT_RT from atomic context. I am
> mentioning this because of the patch which removes the nmi+hardirq
> condtion (https://lore.kernel.org/all/20260113150639.48407-1-swarajgaikwa=
d1925@gmail.com)

Right. With sheaves kmalloc_nolock() on RT will be more reliable.
