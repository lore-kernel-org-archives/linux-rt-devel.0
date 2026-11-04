Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815030;
	b=t7RjdW3ElOh4yBiy/gS3EISPC9yZ/5MdTyyzLDVf7xtEkSSUUb1ki0cJY5V5ilNoGxiy
	 XcHB9Io2/Mmc6GCvrTABt9977QY4Qij7Y2j9MPLyP9VjANAmiX+cOmalVmBoO41eCpbcc
	 c3iOyxEMuuLgQBV4Fv+JybTby/S+7wMAtjLCR23ulbxapThOpiKLYr+TmsC4ldSO3JuCf
	 /P0TJA/d8Do1rCZ8PFe1wgUe1lpPznSacqqgQwrmNAGccrxP04gRBcYaYHO6QMOJ+grwQ
	 /07YHVV1Egm5Tvm0ILe2AiwQ8htfE/YZJwKjlPJtSTPE9Dh0QjUgxayj0dQa64Jzwzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815030;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
	b=O+pVpqIUWZAa9e6aBhBZBzemaXaSWIsRbvjX7KbM0yO1YjEx92o2XHLxXjLSp6MLfLQi
	 1id/4QvCBoF/rBNQR0cIC76yNxIBWQ8A6k3qT4w6oG05j7YIhDJAkoqGwGbhvwI00EoPG
	 r9WaBBn5q2xaARJYitRuRwqPwK8T+Sw1UEmRfN4AdyZiBcfl7BG/uKg1Ccik7u+AEa6RU
	 Y/3r4QPCjJly6sptUaRblXCtrvUcM1mXFMf1L4WxSJBJqZeRoAmZxisnlK/4YbLZhb66K
	 ZqZeYF1slR6VLp+GGil+VubaIsFsA7yqIRZJ+jtf44RM8Ta+A9I2xfyVlBCM26om9mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="RQLgT/9/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3E607AF08
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF3E607AF08
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQLgT/9/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793815029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
	b=RQLgT/9/LCYB2tLGWkjNAyspMrh4zk6ZGjOJ+fclDucidd5Wgxed5dVp9c1nL3M5UlkF4F
	+OCuWUo01TVEFCek+Bw5vma3PEmhEEs0Brp3Y16g2Ta9CueoNqP/nuzlqJDlkc0vfqdnM/
	giIkw4fq+vaxWDowTLP8ots0YbPkRQA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-__ahZSBaMsGoP7rHoz2eLw-1; Wed, 04 Nov 2026 12:57:07 -0500
X-MC-Unique: __ahZSBaMsGoP7rHoz2eLw-1
X-Mimecast-MFC-AGG-ID: __ahZSBaMsGoP7rHoz2eLw_1793815026
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab23d7c824so1277461fa.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Nov 2026 09:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815026; x=1794419826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fb3Zd3ut8454HotwPwPAYB7YyRUaA3GgbhwCbjm8lMI=;
        b=IfHPAzSzM/7hVLrvSXdL24v67w2C80Q5O9S5lAD09c3DEnOV7kti0Rx0r/CbHdNqov
         LPiybZjjwpgnklizndzYfacv9Ht4vEvxRyDvI/QdnvGI7JEXu9DOr6HM5woQfvGjtRZQ
         WhP8nGAOHOYdtStbVUjMLxG6DAasSy6mBeEHaf3Vb2BLUuEN0VzixTjfo73nIySf1onS
         fKrjh7o7/Y4z2VDdufmv4Bo2LVtpbdDbd+RmlF4r6DlmbkBlv5ZRtZK/d7QrvZX5DEs2
         v312ByB0dfHq22Px7wH6luD/Kn0/bDDd/xbJyXfPkjnPQzxFZb7nXYINbQzvMT7PaKxS
         WSGw==
X-Forwarded-Encrypted: i=1; AKwUvBy7xCwqUVOHRff8U22YWR/ybRuw4uA9hyqnnyqjSKVzlMHXfcmbwyukc9sYpU39BCXzRTyNpPVbo/c4b8V+UA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/6jkAgWznW9XmzRFsn1GJ4yxGRM0q3E3HWxbntwa+0lv0F1Z6g
	8msOEfzv/d1Rhi9CPUbZTLrEa+g18DQdu8swXVA3a0JpRZ9Ya1574JCnIfFxGiYRcAYnusbK5JT
	Ig3FYoBSw9kfR22LBZ/fS8EuiEgMqq5gRa6EdaXHvqmXzMNfNbgRYEdah+hjb1AT7fqTESGs5Xm
	Mecm2gfXoJgv3CQLsvQdl6v7XQw3gtrBZPl5iOpiXAPiU=
X-Gm-Gg: AYBFou2Kw2IpUQU4RwyA5PbJYEikXrKWzqP/nHFCyRbLMhh2QMzPYHCdtMyGFH179oF
	Ac+z5p/Jc6Z/fKMOgPENzAvAgB8u/vIPmpByH8bQe2AFT66ysPUB6JW2K6Cx2V/cgxqm5Sxkg3C
	SYi+0squeByKyRbwDt0JlD7x8F3v3raMI/OUIwFD+izx2KeciiF+cdYRAT
X-Received: by 2002:a2e:97c9:0:b0:3ac:ddd5:55ee with SMTP id 38308e7fff4ca-3acddd55907mr4690871fa.2.1793815026122;
        Wed, 04 Nov 2026 09:57:06 -0800 (PST)
X-Received: by 2002:a2e:97c9:0:b0:3ac:ddd5:55ee with SMTP id
 38308e7fff4ca-3acddd55907mr4690781fa.2.1793815025627; Wed, 04 Nov 2026
 09:57:05 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com> <20261103154246.S-8NqN99@linutronix.de>
In-Reply-To: <20261103154246.S-8NqN99@linutronix.de>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 4 Nov 2026 18:56:53 +0100
X-Gm-Features: AclHuK931Qz4UJ3O8Has-FEwEeK34WYcv8yPrDJgYS60eLd8ID20u55CvxuZARw
Message-ID: <CALE0LRsLS9Hsr_vUZ7k6YA4DJB6Su=E9r-F-btpyOXSvv6cMZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix NXP STM clockevent bugs causing lockups
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GcF1AfMYD8m9AcTRSiChlcR5-KdP_hl7koFnGXTvTDo_1793815026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thank you for the review.

On Tue, Nov 3, 2026 at 4:42=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-11-02 22:16:19 [+0100], Enric Balletbo i Serra wrote:
> > This series fixes three bugs in the NXP STM clocksource driver that can
> > cause soft lockups and missed timer events, particularly visible on
> > PREEMPT_RT kernels running on S32G platforms.
> >
> > The NXP STM generates an interrupt only on exact match between the
> > counter and comparator registers. If the counter passes the programmed
> > value, the match is missed and the hardware must count through all 2^32
> > ticks (~32.2s at 133 MHz) before firing, causing soft lockups.
> >
> > Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
> > hardware's 32-bit compare register width, making it possible to program
> > an unreachable compare value.
>
> This looks fine
>
> > Patch 2 fixes the overshoot detection in set_next_event: the existing
> > check only detected counter wraps, not the normal case where the counte=
r
> > advances past the programmed value during the read-modify-write window.
> > Replace it with a signed comparison following the pattern used by
> > timer-imx-gpt.
>
> okay=E2=80=A6
>
> > Patch 3 increases min_delta from 2us to 20us: under bus contention on
> > PREEMPT_RT, 2us is not enough margin and the counter frequently
> > overshoots the programmed value, triggering repeated -ETIME retries.
>
> This all sounds like the hpet trouble on x86. I'm not sure what heavy
> busy contention means and why the device is enabled/ disable during
> setting. I would assume that the programmed value hits the HW after the
> wrap so you wait until the counter wraps again for the equal match.
> Worst case would be you read back the expected value but the HW sees it
> later (after the wrap).
> hpet_clkevt_set_next_event() does in principle the same check as you in
> #2 except it compares against the "min" value instead <=3D0.
> Would this make sense?
>

Yes, it does make sense. I will look at the pattern used in hpet and
send a new version.

Thanks,
  Enric

> Sebastian
>

