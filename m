Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239D2253A5
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809800; cv=none; b=qgeOkmdx4Yv2j/fKuAJsd9ue73Fo1ftFSAczP/vy6TX2Myz3dFVkMdt+6o3wzUMwn7PvY7c8MuUIBwgUw/CxxC8PTfwBlyEL30eY+fyMMdedgW5h1lb27P25ptIee/186/3ntHzZE905i2HSnNSE9wFmlqD6IQ4RyQKAY72yETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809800; c=relaxed/simple;
	bh=WlOHhv6YPlidRlQxUGabWB/Y8llYiGYvkGB43QXy6dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIWSK9az06KLamBVUa0TBYd9tigp3F/W9gyW01mvfaBY2m1DPpEnvV1gGs4qErqLiGb2Y46YxkyjVPvavC4pgvlApXESjWdG80rqoLmU0oBzAXwYdkC/2FEW/b8eRcm9ksd+Lhhl9HZCRJhhu+4C73WTQktKSGxEws9ELD0Ur3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3iqMUlv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3iqMUlv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so2499303f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809797; x=1740414597; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZQb2m4LI3eZ0whbBX38Hfb+TR1d3xUyfma8FbMenc8=;
        b=Y3iqMUlvgaqREO6H0XLHoq9TenGtVDDt0Ew7hppDMqfLgktPnLcIkhxLnhvUuOkhBR
         9GLPOsE2rG1s8A4TUP1T3U9lCdkTXCEVJY7EWTMZyh1l7UTxGZtYvGl846gOaPzYbdu0
         t0MVo1JzGqVatiKT00Mp7GMb8Sa5CjCb6aBLXiMlYGFWmhm3DgTy65ThGF6t0ffZJHXq
         +EtxmmzRiqayqmWifIPxw3y14KQI9EDXsWkAb59f8A5lZxF0O60RiTR4fHwPDYEXzzT/
         L9cjKc7yU3JHMbmPpIu+DeFtzCWwxe4rqToOIRRWusjNTKcCepsC5w93txlVYPc+67Jy
         fGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809797; x=1740414597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZQb2m4LI3eZ0whbBX38Hfb+TR1d3xUyfma8FbMenc8=;
        b=w4urS7IF5a44+wEUsRRpgyiNAEqAoKlNfGCCIoZAkMYUrCqcP4R772zOJQnGFL1W3U
         A3MS64dY6JIn6qw8xN87i+Lmifsb0F7e7OEbru2imvUE7MDYWWI/qJu8XXEdfPSSQ336
         2cwRyPudBtEdKg4lR+veSFZYAafDJV0VIpUlljFUevo7fy3/n+qeW/EJIiZdGsBIvNmT
         N6LZulMidP83q9CAgeCoevyTRlkYj54KJv/RXAlskpRCLwMatcA15HK36v4wBD0fNedy
         2LuEXT32QJRhdUSa8x20JescgZLOQlR2aLv3XNqhKTRTTjC8LQsHkM+hlWktj6V1llXQ
         NeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAbzybIxC/LCkRYFHIHDX9u8BjDRHrQrbWPjMoDX7ZmbrihP/jC3uxFnlOw1aN1RbwH902wQewf1UA3UdazA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXwPLbOGV8M+RWwkwXsYiUh/R6bmX3MB+KyHiNEgXp3SNnQ7kr
	ID5992a9xsLh9avHqMbhI90OwJz/b/efqCwkFp9PI7Iz8ZgKyev2Dhq+tzgtq1e/n9DJ2B/75Hj
	T29MQnhPm1zYea7QhrjLwD0Eu2Lo=
X-Gm-Gg: ASbGncu+e9G36VD1pBteazWbWtQ4XbQ/P0a9UZtZFZ+Xd5ksk/Doyu/EzQtT313/w0+
	Q7eOldvfJ8xFoeQLp1HhEgTpuEtEnj0vAruj6Wl7aNQAc4w7oPcTyhpgkKexXOtEp9vBtSU2hhQ
	o=
X-Google-Smtp-Source: AGHT+IFPGojklZ8rX6C2jIUVXuI7Nu18SntXvHS3iftVKfpo60nJI733DAqjbgFpNf/qFXWucoMCahPUZAaAlZWrVQs=
X-Received: by 2002:a05:6000:1fa4:b0:38f:3d10:6ab7 with SMTP id
 ffacd0b85a97d-38f3d1072b9mr4816691f8f.23.1739809796774; Mon, 17 Feb 2025
 08:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250217042108.185932-1-longman@redhat.com> <20250217154309.C2CMqCjE@linutronix.de>
In-Reply-To: <20250217154309.C2CMqCjE@linutronix.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:29:45 +0100
X-Gm-Features: AWEUYZlZbQRUYlLo8ZMq5M3z45K6gh8vpPysxswkL9MmuffmUF5lc2K91cMG2qk
Message-ID: <CA+fCnZekjO6ajX5YDE2VgL3pzyawdVNkJ0g6-w0Xq15zdDdLog@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <longman@redhat.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 4:43=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void=
 *addr)
> >                       sizeof(init_thread_union.stack));
> >  }
> >
> > +/*
> > + * RT kernel cannot call find_vm_area() in atomic context. For !RT ker=
nel,
> > + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-ty=
pe
> > + * to WAIT_SLEEP.
> > + */
>
> Do we need this comment? I lacks context of why it is atomic. And we
> have it in the commit description.

I would prefer to have this in the comment, but with a full
explanation of why this needs to be done.
