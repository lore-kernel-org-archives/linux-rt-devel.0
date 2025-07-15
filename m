Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA32271466
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572241; cv=none; b=KL+99yhc1yhO8GuYxThJNj5gv69OHBhmAyFzyI/ZBlYEXQaDa7YhXjn3c22um4aHb0cGZRIt5kx5dQlNZBQaknLFganLMPivzHF940PIFjpgMgyfsyMM/eE3+YypAWi6uCNvUV1yV2yFdKFme1uJn7ruznXOaHw+PVpvw2MZGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572241; c=relaxed/simple;
	bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8yD0LQ9Pr74Tah9yFrZ56ec97fnNBOjosWRt4ENIwTjiZbh++l4gDl9YOfjLyvGj2cvnhRdyeg6rD2ck04pGEpA7nuRn3TvYIdrHvHqBc7FOdgmBqFbuRUj35Ali9ai1XTgC5O26ev90Ni/h4UGVLzKd4Cvj5wXGfAuEzmVTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCTEzRDY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCTEzRDY"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e77831d68so52257157b3.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572238; x=1753177038; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
        b=hCTEzRDY5bfdwr8vYd00iX7YKAYSnKLOVeU6m3/li6+7YvE38OtkaZLUmCibBqQAtX
         IhTz31m8rwqY436BnmTjrvgeqJ6LQ7sjIK1i4ZD9IIdleLueGcCcq6oboWcT5TGFnJfC
         dnDZhhn9MIgZvMl71gR73OZnRVxvb2Gulvfh6WjSIuU6R/QbZTgtjoIYpePba65nBf+W
         j311TY96kV2m3mEs7eZUZ71Lk6aGH0KxOIN/PBT3s6gcIUetDqvx/SMS6LBd6NALagxo
         orxephltj6InZHJiFA9omr/veoYmCT5LY3P3BDqnO1c3b/7pJ35c6/Pc+jaU9ymzhGc5
         vseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572238; x=1753177038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
        b=iyDjXwiVLXFTdlOZDgDSRWBuZQ/DyIo6qjWAoTjcBZ8Y+iHiBhEXDGjJahNSaKGBUr
         iuraYVjviSepzsPHEKJR5dlvnjC8PiZ6qMlv8ea9ONRXykAL6VDWWto+Skx8+ijkyPaU
         ZyCO/PcHPQ3e1PxbordCNzg0ZphY5UsgTweErsGd2At6m+QtMihB9ZBJu5V59alhJ2YA
         0h4ydsfI3FTdG5fjJ4a0aZyGJx2kjRnHhgKuE/dnvkF71f0bVr4213V78eBDIoIxMQrp
         xEECTnFkgY+RrzxUQz8+truaY8T+jyqmSh/Hsfv9WYhkhcQ94hCRYD/6Yq8+OTyu7Odw
         RdVw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvG+JjCC3Me1Pb0uzzSVMDIlx9z5/rZ67wFUcP4QSeZ0UZAZXj7MzMs2pnsFo3TtUJrZdBuUxuGF/DU/V4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgDMEszBNH/73nCSi2x8W0tembAkE2T/z4S5R3eMeqb9MmBcjf
	Zsg6GbGK4mjkZTdJPlIkVJp/bMKRHj1r02JF34HSBGmrOE3awy6CVm0PXwvMxyBjHDbNBAsZnCN
	HK5aziyga8Qf4qF9bVnNMCf8JZk1s0mg=
X-Gm-Gg: ASbGncvJtLRXceKV8Bahh8a+fE8jP7jYr+2544eotPsaAi+nsJXXdI1D5veAt64NVX9
	Y/izckUPFIuJHgdyRSDAzL9au+lowC+nh0y/YIFnNqdp4LPjCpV70BF6y2aU3W3nASmFyWXqcTe
	EJxxorrxf0MOeT2aAIwo6Q8aaA8slt+TgLNhhlegigFrvjvJ5+MYYdvM9pJuSgI8eN5lWU2g3em
	rS0x57i3N3eJDQU9r6mZE1CYPZb6n7F75O/560b
X-Google-Smtp-Source: AGHT+IGszuXTqF1d2MpINKB84ihNgCbgFwj/jgU2Im2zALJ0/JAaLqyVNXkuBU2tbjjyUyUJV0BYW1r+8WZLaowO+l8=
X-Received: by 2002:a05:690c:f14:b0:717:c40f:be9c with SMTP id
 00721157ae682-717d5bc0652mr238606637b3.9.1752572238134; Tue, 15 Jul 2025
 02:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250710040607.GdzUE7A0@linutronix.de> <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
 <20250714101410.Su0CwBrb@linutronix.de>
In-Reply-To: <20250714101410.Su0CwBrb@linutronix.de>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Tue, 15 Jul 2025 11:37:05 +0200
X-Gm-Features: Ac12FXww9z7t7Gv-dsrgtaU5Nku8ycGFL-OoVY3DiaRjmA8G4fLemU3BxN0zPaI
Message-ID: <CAKQ1sVOYCFS6PD0u1yssDj3=8mDmi1K1Sfy930qYWeCfRuF_ZA@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Xi Ruoyao <xry111@xry111.site>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:48=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> And my lesson is that lockless is hard. I still have no clue what is the
> bug in this patch.

Maybe this is related:
https://lore.kernel.org/all/20250704180804.3598503-1-shakeel.butt@linux.dev=
/
?


Regards;
Yann.
