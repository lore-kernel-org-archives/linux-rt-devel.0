Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B13BFE25
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667121; cv=none; b=ugE/hmBZDR1AJKRCbeQcfals2YjCB88o2/oAeMyb3TPk9f63RPn2S1XsHvHMePYV8GYxhEVk36OiNBHVt9SMpgUSrZY1Wp0jYidKODpQVx9M08VqxIZpscjrRc4m+mumWcVX2NXHRACnIqlSvxBtMVHx4ryMGghl6Rz6uvMKboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667121; c=relaxed/simple;
	bh=SSEFVYhF2Pg3TbzBC13FrS3vwkfQJZGZ4K20/HU793s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsAFzpCVXw9YvH3lCPaOzi19FTo/rzqML/9mFX57yy3IboxmKeDQLdGwmB/g/CDycc5yQYRM2hWPFNHjrfC5q8fA+En+Z1QmG1bqEloQd6d7Y0xX2Y4I+yi58buhwyRZm2SCtM4gdUUd5eZfa5ziS18Z3gZ5xmZOjI+/d2NjGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEF1GnnX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEF1GnnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783667119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
	b=YEF1GnnXoRxftdBKMN9S9hsLuPWtkjaiuXv0RlanHMtFpBBEfHCw8vPdzFnMnNkZXK98IJ
	PV+JrFRMe/k5D4L7eTQoomqIcymjloUn+qysnmL4o/H94kUlMTLC5u5wf6nnaS7t9RuHy2
	TdnWORwCMaqCaH8X+NQgtj9WzoXMkRo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-iaGIrB2IPUmTvnEe-QC9NA-1; Fri, 10 Jul 2026 03:05:18 -0400
X-MC-Unique: iaGIrB2IPUmTvnEe-QC9NA-1
X-Mimecast-MFC-AGG-ID: iaGIrB2IPUmTvnEe-QC9NA_1783667117
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15bddba688so61410466b.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 00:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667117; x=1784271917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBLtI1cgq6P50LRB2gR35deeL3jow5HhR1wudht4FTI=;
        b=T4Lr9S7CU+1Y+K6+h813qksY9JCqRqc1RT2mDpC93c+6YqhAbTq9wO91yyLK4iKs/w
         st/0xVFSSmuLsdOHzIxREB2aa4AgslH4aYKnXY0ZSH6gMvBppMMDbCdasOkbQTf7j0e0
         YunNf2SYgfTDgRAUhW1a1SeAxB448A8uHcqw5hqcnE3nYH/R0zcQ25MHlAYhuS7LxABE
         pH5iUxne5YtfzT0y3kAtGSlbFNtGdqj4gP07813DAYwt5tmoMq2j5KF2wcpvTytZ6BAT
         KJcdrQ5eHpvcDNIjKIlJwfejUUhBbSwkNs4Efvn647wQg4p1i/2dg5b/TkynSW4DH1Aw
         P6KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rop1C8kpN3yybR4USC+44CTIfEXP/I7rwdo+a1/kaZO35xPzaHa883omAQphIW8isvYfOzGsGD6JeXyEE7wPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyadpZ5t1ZT4VYWaLy3gqnP0oFORo9v3tgwZzxIOo+lKEpoHOSZ
	aZJIjm/qMZGp0Ll3vf+5PLnOpTJkOh0k5xj7lYxZOO+EVOO/Ij8hgLXIxy2wgM/OCRTYCyrBI/c
	HVP6p4cZDmVlnhrrwjuwVP5J7a/ixDay8d5glU1Ejxp3UuvC2agBYEUxQ/3XROn1KZNmMLjxsSd
	3qIaYeLK9nlytYIpFbc0l981gk3hnFn2HuPxCEltvafDA=
X-Gm-Gg: AfdE7cnd+V2wOH7B32J3P93F1vEnfp60pm/jGBQbbBVcgRzYdC0TclK4CgJoQy69HUr
	/gu2ONG5sfF8rS8AC6PuSYXDbj8c38zH1kzVAljlotbEAiJ082hZVX/C32jwnj4S6G9otjA41io
	tU+wTIbazUzKbSLPVSH4GwglvCLS6Ek6Ml0ROgUtVafk9RjDk9cahM7e+R4MYdN1sD398opplXB
	aAUeOys6nZmH2jC3wNPip2mjw==
X-Received: by 2002:a17:907:e153:b0:c12:b227:c0c8 with SMTP id a640c23a62f3a-c15ce128cecmr304103666b.50.1783667116724;
        Fri, 10 Jul 2026 00:05:16 -0700 (PDT)
X-Received: by 2002:a17:907:e153:b0:c12:b227:c0c8 with SMTP id
 a640c23a62f3a-c15ce128cecmr304102366b.50.1783667116222; Fri, 10 Jul 2026
 00:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709143108.UYeCUUcd@linutronix.de> <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de> <ak_GDsJS6kVoUM2f@lysander>
In-Reply-To: <ak_GDsJS6kVoUM2f@lysander>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 10 Jul 2026 09:05:04 +0200
X-Gm-Features: AVVi8CeKVQ0uRzsjMytyaivMBV1vQN3ibqcr-YnmwljEDV3qGuwBSJSahwRmcYU
Message-ID: <CAP4=nvQ1GNkD5h9Phr43Usm3pK9xQJT68eOPxoQ3kLMHE0v=Tw@mail.gmail.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
To: Clark Williams <williams@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -JPm0QtPvEjl6IIbUoAMGoJLkn4QOceXJy9J8JS3GrA_1783667117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 9. 7. 2026 v 18:03 odes=C3=ADlatel Clark Williams <williams@redhat.=
com> napsal:
>
> > cyclictest (from rt-tests) is using this file but only while collecting
> > system information, nothing else.
> >       https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/s=
rc/lib/rt-utils.c#n528
>
> I'll ask around, but I'm betting RTLA checks for this as well.
>

RLTA doesn't check for a realtime kernel, neither using
/sys/kernel/realtime nor PREEMPT_RT. The only mention of "non-rt" in
the code is a comment saying you will only see softirqs on non-RT.


Tomas

