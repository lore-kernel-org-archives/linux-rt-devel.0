Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AD256C6C
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Dec 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503285; cv=none; b=XqSfYfmkOGpl9Kw8vR0VGraHgQQUDXhEvy+09TgovGPFSSEc6K29QAmKO/J0r8KrtemzSQnCfy7+VQUMzlV1E/APq8lx4xg/2C4fWGDEe/iae6f8ewj0h0/KbWJVBxwXWeJkNpR8lwRzW87FDOBnhUftSUgTGx6F3REVFPHSpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503285; c=relaxed/simple;
	bh=mP2xfOnRZfIAueUZPo5/b7tVu1PN2HIzvA4puU7q8mA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFoF/ZL+JAXkMPwI1LCu9N9yzn7C+gtGlDtydFOi48KgueVsRwnzoIDLCL9HRH2KvkUcq/MCjgVgE4d8xpEKLPYyhJ8wjdvwN6w6XXUpEZuPApmSBuHRW0aO8f8cbWyZ6RgGWzu8hHeZkAfS9lJ+8mHSLzadZoQ4vlka7b+Und4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pe8scNCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe8scNCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766503282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mP2xfOnRZfIAueUZPo5/b7tVu1PN2HIzvA4puU7q8mA=;
	b=Pe8scNCTsICK4IV1swHr4Uk86FXp3O+7KBUqOYp6hcybBvO9knp3Pi3NyQUxMYHtTZM9qe
	BMsdGFa1b1pJApyPymq9tuSBDeA4LvwWuzRwFG9H7wng20otykk48QeTjLHBGTKvtXsPQA
	OLA6dTXBbpCw8XTNCyilxeZZuFia9iY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ierxvZpbMu-vLveO0TXkOA-1; Tue, 23 Dec 2025 10:21:21 -0500
X-MC-Unique: ierxvZpbMu-vLveO0TXkOA-1
X-Mimecast-MFC-AGG-ID: ierxvZpbMu-vLveO0TXkOA_1766503280
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43009df5ab3so2835804f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 23 Dec 2025 07:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503280; x=1767108080;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP2xfOnRZfIAueUZPo5/b7tVu1PN2HIzvA4puU7q8mA=;
        b=j8Ow5kKx+amALRcnGALDIbtGZeKNhe1MYQv70WGHnwECZmplTb2BnhCMTnn8GySiev
         3Jgpn2dfWTzPPz6wD80Ww0h5o6gE38WdTaxawciLcfzf03Oso8HzH+kedsKoSbcipR2N
         bIghedbrJV0kQBrWPckPvPUpssvv/RcHokJZgmKUdaflbPMM0Ff0MvOeVvn1vyly/6Zv
         CXay3Qhgr37kh8Hpej9ftxxSzG9nqeshSiNzW3xvzRNFyRXq5maVM6wPiAjSjy5BLjfk
         1ueDmoxKgF617O81wMiXj6uBKS7S08lyWM0YPJLiHpBt5SAXC9lWjVXEqo8zWz+4CV/X
         1syw==
X-Forwarded-Encrypted: i=1; AJvYcCW+HRn1o8Z+B4uPFSXUXwPMDjjh8GO4P6xLw/DBQGD/mi/RDR91rPFd5hbSnQy3e+jsX5XxGFVLbfiWj0MCNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkrI40T0bsx7K2gePVVkGqqObUrHE9JZ9zwE5Uu15rrx309AZs
	R2HglBiFkLbdThzCRc37bJ6hQvfsvn6ffzXHJPKYryTL0jcCJBPqjFNVwKanptQh/j/p1BgGVMR
	w2cjZuhPIIy4SkUQncpHY/roaDBLDh0HkEvrRwLkpa9J9L7x0/PpGf8chdqytT/kF20N/
X-Gm-Gg: AY/fxX7AOJIJO+0TjMRa6gzoMvgi++YVYYNZko8WY2M55MSaJ8Gy9FFyzL4T+F82N1O
	eMDSdJMSvB+BSi1AhsQoTDFsmq0PhwWj87eUFzPTwPXbRmbVcJycFexw8I+Uk7tEQXlCUC6Ewd4
	QLPQAuGENfOFtB/UfL0Favg9m9PgIpCLA5lonR/BvJvrK0taHUpGo7HcmOmCXweu51gS5HFCtsB
	cPwxlPQaFdjG0ZEJG2jmX6nf533G0daRylouwVA0pGCexM74H8emfhjSUbY+aHZmrEiwPT4hCpp
	8y04bmBT4moAQ0gv/KEzLQ5npq3gBBxa2zVWEdu5359mLYa8jG/VEN1aXE2R87wQcDvPtLTyyhH
	3d6Ef1fQYLBv9oxZzzTEzvHTOV+3hxeisLJyR7xycywgCFFMpCoOsJWEA6JUV///2ujjnBYgfJ8
	wV+2D74OaG
X-Received: by 2002:a5d:5885:0:b0:431:5ac:1df with SMTP id ffacd0b85a97d-4324e4c0a8emr17448187f8f.11.1766503279352;
        Tue, 23 Dec 2025 07:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYAqtmVXRmtmnSXxRYPfwHaCOlHVNgXuHEop9haWGNrA8D+acuq+GtZUVEOtNJU1zZ6J3S9g==
X-Received: by 2002:a5d:5885:0:b0:431:5ac:1df with SMTP id ffacd0b85a97d-4324e4c0a8emr17448163f8f.11.1766503278954;
        Tue, 23 Dec 2025 07:21:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea226d1sm29012815f8f.13.2025.12.23.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:21:18 -0800 (PST)
Message-ID: <c966b103b002e520f5a4bf80b18835a485cf0cfa.camel@redhat.com>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org, 
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, 	syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML	 <linux-kernel@vger.kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Date: Tue, 23 Dec 2025 16:21:16 +0100
In-Reply-To: <92a7c013-0676-4c81-867f-b55c69a1edd6@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
	 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
	 <20251202112644.YUux4LKd@linutronix.de>
	 <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
	 <871pl1y3oh.fsf@yellow.woof>
	 <0d06ce4c-6ff2-401a-90d9-5a4dfd2abebb@kzalloc.com>
	 <ee8474631ce309539918e17b60e4ca150327115d.camel@redhat.com>
	 <92a7c013-0676-4c81-867f-b55c69a1edd6@kzalloc.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n6-Ev5SzTPn9vOZwFE_zk5l6X0hEJcgMHtY8kzffHSM_1766503280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunseong,

> I will also double-check sleepable memory allocations in the context of
> PREEMPT_RT kernels to see if there are other patterns being missed.

You may want to play with lockdep as well, it's much heavier but can catch =
a lot
of those issues. I believe it still relies on annotations though, so it mig=
ht
have blind spots too (though it's battle-tested on locks).

> My interest in this arose because I've been seeing these legacy patterns
> consistently reported as bugs in the Real-Time (PREEMPT_RT) kernel. It
> seems many kernel developers are still unaware that these patterns are
> problematic, partly because some older Linux learning materials actually
> recommended them. This makes it quite likely that such code will continue
> to find its way into the upstream.

Yeah that's quite common indeed, I see kernel functions claiming to be atom=
ic
while in fact using (sleeping) spinlocks.

Reading the material Daniel left (RV's original author), he thought of a si=
milar
model, so at least we know there was interest in this kind of thing.


> I will keep looking into more meaningful contributions for RV. For instan=
ce,
> I=E2=80=99ve been considering a monitor to detect excessive memory compac=
tion issues
> under specific workloads, which I=E2=80=99ve encountered during kernel de=
velopment.

Looking forward to knowing more!

Cheers,
Gabriele

