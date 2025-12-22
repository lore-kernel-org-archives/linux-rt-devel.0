Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BA309F08
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Dec 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389241; cv=none; b=MwjXywDMx2S9tO/tau07OZzbo7W5i8xD4sbYWLcEV706PCeiI2owTx3Omhkuo8gc/2blCLHvgvlB38AgpEVAz/EYT4RSjkpOCxRL+0dz7Y9qNOKCTtieEzC0np/BSmy6+w5CF6VVNuW3EnBzqm++icO9LGJYAyyHTku6BtfttWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389241; c=relaxed/simple;
	bh=bD3Th9oXpZgvOUOXrHo/WcZuW4ZPE3M2cjZpHWYh2Fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvrx8l1RnqMkmPCzp5FweuTEfFcHSAHEflnEnY9ClKC6CKRDN7PfBq/uZejCRKSyj9fqD6IbiLj6ex8Rq9jtecO5wA7apiVy3S+EwIDzX7SSKBO/jhYCH2DHIyo2uNNbHIRmYxqUu9uGkCRLXuFljI9aixSK9MIVZJakNIZtinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8qFYaR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8qFYaR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766389238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bD3Th9oXpZgvOUOXrHo/WcZuW4ZPE3M2cjZpHWYh2Fg=;
	b=Q8qFYaR45J1az23kqvSo332RiOaFufoEQmM00yJwQxqj7s8irhiYDiXCErL6Bnva4gvPx0
	VimIUq8hQ9QzbDSEVnlA1GpAejCmWGFJStSxiH6e71Veuy52wEzgd9q6m7hiclh6xFmrb5
	kki+XYFWaj7gmJ17cANwyaNpSkOQlIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Br3fowwRNbuQO9fww5io3g-1; Mon, 22 Dec 2025 02:40:34 -0500
X-MC-Unique: Br3fowwRNbuQO9fww5io3g-1
X-Mimecast-MFC-AGG-ID: Br3fowwRNbuQO9fww5io3g_1766389233
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so24477845e9.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 21 Dec 2025 23:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766389233; x=1766994033;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bD3Th9oXpZgvOUOXrHo/WcZuW4ZPE3M2cjZpHWYh2Fg=;
        b=EaGNHa5kYDWj5DXKO3vk2FLHQDgj1W0HY1rdlFbRtZeFFA61qQDIDrNItk1hPw0ihG
         LnJ3gr933am0PM6NfSsxOcA5NjW467XKpJrc99Cm/MecgF9j5oL5nm9edaaqX8rARWKj
         1rSyvVN5L8omuNimTUh8FUh1KKwtBZcCVSdiIPC7Zj/SBGNvj5y2EK3T/Ay/QpXVq3n8
         jQaL5otosnUx3i+LMZ2MjBJQpzwpVeyT8HaAheEOpG+NvMimSuFQ/m6Rau4tOOAxe6ut
         /sM4BrqbpYjONXDEuFsqqGqxg2llbBBWdGzxtrmH9ANGormEBBGQryui3uEpmfkw1G44
         zw7w==
X-Forwarded-Encrypted: i=1; AJvYcCVtHnzMvjuBvWfOSBe+bG0zAWEEXUG+6J6m3Myq9p2TjVoHiL0+NvqhmyJvOvfGgTHuASJ2caQWzN96qtTrhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfhC21d4g1ziWg+sIaWTWEEE121WGIqzpgdwnfnPzYKpoWGbbK
	yEgHyDzbJlotLEEiIaXdhXqIh6PzxavzIzkdO5Fsu1CDif+kx0EdYUY0Q8lv8BOQ+rdPo1PKRXU
	lhQozYtfGvSvfcw+3vSFWQ/0RRmFJyaK1dbAgt7yRpy6+A35Nz118qmb5C9zaJ4H17r1S
X-Gm-Gg: AY/fxX7AYhCyCQAyy9AqXBtJkeNR2tYAO0B0NLJ85X8dmyf4HJQjfgSbSw0SeLSMogF
	JLfkxqdYlT6Gs9625uACLglaaB1cW0Jz1H5m7YKBHCE9hWZPN3MfHgZBWl9Lke/a/w9rV5SkrJZ
	Lm0T3+yVaEhXuhwQsmbZykXKcj//moyqdA7Sf1kY5V9p5HCKxLkGMOVAc8UuJkvoF/wcxF7eShZ
	qtPwxLBUD6OVvj5V0V3LHcVnSZZ5SZ1t/dmuap6Y//MRcH7qPz9t54VjTBlGZtofAOtvL9jQkDe
	ae4cTBzhizQWmBMn0BucuhJQ6eAAtP+k/YNFjH+3DGb27masMTgeApMDF+rHNkeK9CfPXhRAFkW
	FGwAzo09hXHThv/KZt04rjzH4uNULHpEc9yeAOdsytGAmhKEGw7TGp3f6J+67HxvK7HuTHhKHOm
	+QgS4CiIrm
X-Received: by 2002:a05:600c:4fc6:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-47d19576cc6mr103507905e9.17.1766389233281;
        Sun, 21 Dec 2025 23:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV35AhXNHaKDsM+gyviDaijn4sQ7bbYpPxD/mEWmBNQuwWBocnrnXP0o1jzUsVmqsjxAwIfQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-47d19576cc6mr103507735e9.17.1766389232918;
        Sun, 21 Dec 2025 23:40:32 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm20673297f8f.15.2025.12.21.23.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 23:40:32 -0800 (PST)
Message-ID: <ee8474631ce309539918e17b60e4ca150327115d.camel@redhat.com>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org, 
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, 	syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML	 <linux-kernel@vger.kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Date: Mon, 22 Dec 2025 08:40:30 +0100
In-Reply-To: <0d06ce4c-6ff2-401a-90d9-5a4dfd2abebb@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
	 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
	 <20251202112644.YUux4LKd@linutronix.de>
	 <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
	 <871pl1y3oh.fsf@yellow.woof>
	 <0d06ce4c-6ff2-401a-90d9-5a4dfd2abebb@kzalloc.com>
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
X-Mimecast-MFC-PROC-ID: 5zeAf90h7VY2V7tyQB36dDG-JLWoYFF1mTNGLMkR800_1766389233
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 16:58 +0900, Yunseong Kim wrote:
> I am currently considering how to model this to cover cases that go=20
> beyond what CONFIG_DEBUG_ATOMIC_SLEEP covers.
>=20
> My specific concern is about custom functions where might_sleep() might=
=20
> be missing. In such cases, if the code hits a fast path (no scheduling),
> CONFIG_DEBUG_ATOMIC_SLEEP won't trigger. I'm wondering if RV can detect
> these potential bugs.

Hi Yunseong,

I finally got to reflect a bit more on this.
As we discussed at LPC, RV wouldn't help with not annotated functions becau=
se
you'd need to add tracepoints there, so probably the best is to just add a
might_sleep and be done with it.

Other than that, I double checked and CONFIG_DEBUG_ATOMIC_SLEEP is in fact
disabled on non-debug kernels in Fedora/RHEL (and I presume also in Debian =
and
friends), so the other concern you raised is indeed valid.

Although perhaps rather unlikely, I'm not sure we can completely rule out c=
ases
in which non-debug kernel (where several other debugging features besides
CONFIG_DEBUG_ATOMIC_SLEEP are disabled) behave differently enough for some =
bugs,
otherwise invisible on debug kernels, to pop up.

Another use could be debugging kernel modules on non-debug kernels, perhaps=
 to
avoid some other debug features to be present while still relying on the
packaged kernel.

For this to work you'd need to add a tracepoint on might_sleep when
CONFIG_DEBUG_ATOMIC_SLEEP is disabled (and it's currently a NOP), hopefully=
 that
wouldn't make people too angry.

Again, none of this would be ground-breaking but it doesn't look useless ei=
ther.

Any thoughts?

Thanks,
Gabriele

