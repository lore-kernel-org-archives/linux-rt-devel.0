Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEF23236E
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818790; cv=none; b=ZOZD0EM9HfgLPXbydMx9DebuHeVSwhnoBsC9rLtR+A1D9I9hGVtM04FAIOBvoEZHNkdAJSllkfZLSxpUn2FwegIBguUOoVkA4LrEQQ2s/2fS0TEErCwutLNLePadE06v+E+IR4RVL7dfx3tbS32SBGk1uO727vOSnNmFFg/ptSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818790; c=relaxed/simple;
	bh=Vorx3UkCYgOJrLzhNIixDKvbQt/xQs6WeZhOlbJTBAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUS36jBc4B9Nca5tQwPaU3MkwAKEWG4Id6MbZQYbY56q0AeL6dTkBp/3eRLO45fTogjigUXcsczoJLSjLujmhHEvF/23JGYiV7v3s6v2QaeCw7yJju9ZQ+E4H2G5L7MyaYIjoMgp9CayyGoFfZLohkVZVD/G2h+CnJvHDeXLtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+2vEy7a; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+2vEy7a"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38de1a5f039so4561451f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739818787; x=1740423587; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK1f+sf0+Cg2T6VQTOIDYxT0Z22QiqhTwWz3Vtwgu4E=;
        b=c+2vEy7afqR6y45XLf5CFxnRKWV054QDsDrdQYu2wOvyx9etmm30p7UfNsp4Zd3fcS
         I/o6KHtp5F3c9oZf+hs1qyYBph6RVe0EibiPZhJNmlJIazoIkTWfwH7UrLl+5YQ4hAfB
         yOH/rdAIhqjVfH2+zjGy+WO/ent7EwMIXJbJJMqUPy8THn0CXmHuYAt5NfdfDzf0qEtb
         Jf2FlACCUCQrB41veg9P3mR1iaIQ+69AxiVbu+0Gq8WVyI0w3E+R1xGhdVxMwGa3RbpM
         feRXosn9tvj8R26ziimoffP5cmkU+8/vnjjyTw+yU/HuJo13STNCr68V0CCTtmXIz8zk
         QMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818787; x=1740423587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK1f+sf0+Cg2T6VQTOIDYxT0Z22QiqhTwWz3Vtwgu4E=;
        b=fL8OKe2rpUUHOR9ewKeCfEYZeyZ5qbkScN68IIh2QyO+zTELl6dRFiqw9QtOn1V0fk
         YypqohbYuY37uA/10g/5Zm4k5cJULRd2aCt2CfDLyGoUuzNWagleETYwyVDr4V7apf/N
         xQunSq0fG/TD6AGIffGhiN6ruwESSbIfbQG55g6SN8dQdFz/aO1bZMzFKDYIXuITpLDo
         bjk3ibqBtkVgiRHLnTXl+76I+38/WURuyT/j7Thyf/iuPefxkHlpHxj6AyQLzrYiPFws
         ezJxynoENq0AwuO7X7JtlH+rEsYcORjMsU+aV2mTFzACtk2BlCJh4DyI+Ztiz8KpQq+h
         Pyrg==
X-Forwarded-Encrypted: i=1; AJvYcCXHU0Vz5ed9bl4iQZp8XrgFOvVL9qZ9ITLWqGqSPZy7+O6zWxs+q2tJh+W3UGPefbnmUu+V5PScb52cZgc/nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGxIcagkJQ+Gg14DIJnyAXf+YBPHmfUVGJpKWWqhoNM9MW41TI
	N39n4wvd6rqxj+cs26Uuyc1mXxA8wRlUd3G/R8ZmxFrOvh/3ROtSy9k+T2k2/y6K5UkmRwTu52Q
	CjnWLTYl8JRaqg7kNiloOuBbUyZw=
X-Gm-Gg: ASbGnctS31gWim2wT90vvNzbKIX4vi7TdTFGy4Fa4KKOakqGNwQA4c1bh3cx3qIEX3P
	NsKrdH//9Z3VStA2WXwbzqnVI5NjGndmXFMLjgliGt+E9aTDXy3pS4TyojJu1IapyalJOrAWXha
	I=
X-Google-Smtp-Source: AGHT+IE+k7Ek80Fa49RAv5Y4RAMxa7oY9cdhckbc6E7hMvsLWp0sBlYpearNUkEvu3arEOCU5a8iKWcfYHrPyJQ/yHQ=
X-Received: by 2002:a5d:47a7:0:b0:38f:4f62:7e29 with SMTP id
 ffacd0b85a97d-38f4f627e84mr1592906f8f.26.1739818787231; Mon, 17 Feb 2025
 10:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250217042108.185932-1-longman@redhat.com> <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
 <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
In-Reply-To: <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 19:59:36 +0100
X-Gm-Features: AWEUYZmoRBvkdpI9_aKr68h3AIVmSuRz0ygJyNHx-ItVSg0Df3xpQx3Z3q7nhsA
Message-ID: <CA+fCnZeBuWMUk4n01z0tWf65dvyBvLghqohJYKA0WkQ5pMjdEw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <llong@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:56=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
> >> + */
> >> +static inline void print_vmalloc_info_set_page(void *addr, struct pag=
e **ppage)
> >> +{
> >> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_S=
LEEP);
> >> +               struct vm_struct *va;
> >> +
> >> +               lock_map_acquire_try(&vmalloc_map);
> >> +               va =3D find_vm_area(addr);
> >> +               if (va) {
> >> +                       pr_err("The buggy address belongs to the virtu=
al mapping at\n"
> >> +                              " [%px, %px) created by:\n"
> >> +                              " %pS\n",
> >> +                              va->addr, va->addr + va->size, va->call=
er);
> >> +                       pr_err("\n");
> >> +
> >> +                       *ppage =3D vmalloc_to_page(addr);
> > Looking at the code again, I actually like the Andrey Ryabinin's
> > suggestion from the v1 thread: add a separate function that contains
> > an annotated call of find_vm_area(). And keep vmalloc_to_page()
> > outside of it, just as done in the upstream version now.
>
> I can make the change if it is what you want.

Yes, please, I think splitting out the call that requires an
annotation into a separate function makes sense.
