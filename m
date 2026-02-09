Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D536C0BB
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Feb 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635054; cv=pass; b=f1t9U2Bxt4W5SOCGiJz0TI+Wb6BHtInWYj29+z0+3H7Y9P4un+PTg6f95IT9tNzjmbDA/54f0OzIFD5KIr4U1uuVZWWc/kKS9eilyznV7NCTgLXEBIkdbHU91Q9RP31akmXF4tqQCzTrHnARPzsVEiOI29qdsOqwaIp3XXZq3k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635054; c=relaxed/simple;
	bh=JAiWmBCCEPyc0JQWScBFRX3hfPSMgstOHCCBiGGXHY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REuV8qM9quCrGq1Uvc3FMxWOOyEi3iAXkBJ/D42u8C5VKRPrhlPywO0RIcI9mRHOR+Du6JmgpCA7tBO3djqQmZ9iT5SJnGCJWs7K8j3OKbfbjGJxHSSc5DIa5zP06vrNW1/wuL3k1p6V9y0w/jVujtm1QTphq8DHVZzBHA5YZxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey1E4qfg; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey1E4qfg"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233bb90317so3724387c88.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Feb 2026 03:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770635053; cv=none;
        d=google.com; s=arc-20240605;
        b=R9w4otClcGOUjn0bBL5Mx5HepQgAYTF9XN7jP4sn7GDchoQElbbGRd1ShuoMqDkNmr
         u42Exj7UwnIiAH+ATdOEMWubIbmJMrNcYA/lvTYyKug3wtMv+/aM2+w/lplpzyDIXSTw
         00gkYoeZ4NBRsgt6+2d5vMPuWDOJ0b/qTUCVwbY/4HAo94qVZ1yowNcIWmJObR6wTPIW
         6bj2ML0BX7iim4SbQRUe4krxG+eJ0hehM7vWefZIMJOgRnC8NwZLKKsR1lx6zBiiPeET
         jki14QoUFVTHpag0mgcpEncHNgEReBuS9zyMIL5slvjHxHPdnZo5CzZtsWo+wYfdlBpC
         Uv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        fh=i3+s0LrpRh+d2WowAJ31n8sVDuJQzwCNHKH7MZIRD+E=;
        b=a0puGbFYUzWIjXlxJ0OjjtvjIF7oUVaZaFGqLFvZUhMXsXx3OeqJ6XbAwula2v90ZN
         GDYQH5pKa5UgjqA7jEZkfQPuc+yaLA2jqBvdCtJ5QHLxfm+9auWXVrQuoH0P93m7Cwgx
         /Ujn5b4095lLexHX//tQQpSeZRbsklexbCcic3kuLUpJXKf+qtlOUI/0Bzdpt8CgtDZa
         xsPR33504fBi79w0XzGcags8ntlNs+OGo0TQMSegcpiCfUJU0Dk0vToru9aKTX/WmBEE
         04csa9rDhWNSFBwGaEV0IxOHCQ0++6wSf/Mv0thnglw9ijymY1pOVDQraDw467kSigCq
         4I8g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770635053; x=1771239853; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        b=ey1E4qfgcjqvNXLdN2F/QCtmYFXNJzgh7AZ7hRH5g0r1ILPGIi6oMX+tb3J4NAs55W
         9gB6xPWlm0ol+853Lb5vo1QT13c4iI9Xie2CQMuNea9EiubHnwP1v1YwgBnbPDU0jJii
         4bu79sDK7JxtgEygk9H5crc+6ZlUvknyxoX62OA93UtHmNko0eWPTBS2W5XylS7pzIwj
         eK25MCKErOUvoob/fvgIFAuCvazGUDOwc6uRgNfnghT810OUVAH1eqkZ+75VO01AXnjv
         j7KoLQsAbXN2feDGs2lUFnFT1Pk5lBUFjcfJJRzQgSUgtshfcc8aIrn1YG1Q6LK2QWjO
         m/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770635053; x=1771239853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fC+F2yjOaiS5pvKP3Q3XskOiXCFukEIUcEt+pbP8TjY=;
        b=Pzs6WcGIyNaTb74XJD105GQPq4qc27Xg9SpU3ZMSk57d93GufThg8eCWNfTrofR3Z4
         XShWzY2aCZ/ykvwYvrytz9I0BF5solpkcZd3Tp8Uj1W1N7bMOEFAholzOxD51fGOMpJH
         pCQX1EAidSqxUvUoLQppkTg2cVRekGfp63e54D5QHWzSqitz6g/OtA+WX0NM2ZlH6xOi
         VD+mYcLBpL1SP960vDIG3rTazbzAUdqHuhDpQHK04tuxMh/c0HhbVQLZBGfalgpKEZZg
         PePsMSP7OTbHoMM/hQQSv1djLFMGQBo8eIPcq34NibSOx3pdKTwORzJgqCryWq/SPTRR
         SHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGy3n9bFxMc0XvfLGpZsYeVEYb4gkv0uAzoAstWYP2FIgqPWmRt2qfLg0H537DyavmaBmxu0ddTydQ8Q46/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJhux16relXKVeH/RMQnW6SomFJ/2BpwJA+TwcLf/2Q2MvHwC3
	qu/6R+IR4NcnCJTdD9DPUyZl6HpCGB/d2VpyK6yCwbu9qWe92Pe5pEl2Dnxs1/mG20H3z/Nu4bM
	lr4E1FCvnVM+Y9mzRRVGKlmOFUypIdGg=
X-Gm-Gg: AZuq6aIQyv+3uUxhiBbmXZNk/RLRZY6PvmVwhEJ1KFFC2nbMLuhDLaGC1noJf7fPXYh
	gA2IZqsZA93RIySpAM1ZjLQ3P0lCzFmFvp/a1G7vByS3HYGX3EXpJJ99eD/QhJxI96BqUZF/3C2
	OuD7bVUvYLLIo4xLk+wG4MA1fwZAfD+raDJ2VMyjhTCpWSXIs/mrn+Nl2E2G1lAOA+vmgZmDTe2
	AlIGcpYcBDHadmCrov1MWgKM4+R55O3m+4OQYFNDXhsunoo5AqcskqtZyEw+Qcxx4W/rgo=
X-Received: by 2002:a05:7022:698c:b0:11e:3e9:3e92 with SMTP id
 a92af1059eb24-126fc1e223fmr5913050c88.23.1770635052461; Mon, 09 Feb 2026
 03:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260208164033.457748-2-ionut.nechita@windriver.com>
In-Reply-To: <20260208164033.457748-2-ionut.nechita@windriver.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Feb 2026 12:03:59 +0100
X-Gm-Features: AZwV_QiAcQaOSunqwtuX5L0vA3ln57D5IMRDmzftHTXJqxKWMgoOcoFu5ti24uA
Message-ID: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ionut Nechita <ionut_n2001@yahoo.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@newdream.net>, superm1@kernel.org, 
	jkosina@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 5:42=E2=80=AFPM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> From: Ionut Nechita <ionut.nechita@windriver.com>
>
> When connecting to Ceph monitors/OSDs, kernel_connect() may return
> -EADDRNOTAVAIL if the source address is temporarily unavailable.
> This commonly occurs during:
> - IPv6 Duplicate Address Detection (DAD), which takes 1-2 seconds
> - IPv4/IPv6 interface state changes (link up/down events)
> - Address removal or reconfiguration on the interface
> - Network namespace transitions in containerized environments
> - CNI reconfigurations in Kubernetes
>
> Currently, libceph treats EADDRNOTAVAIL like any other connection error
> and enters exponential backoff
> (250ms, 500ms, 1s, 2s, 4s, ...), causing delays of 15+ seconds
> before successful reconnection even after the address becomes
> available.
>
> This is particularly problematic in Kubernetes environments running Ceph
> on real-time kernels, where:
> - Storage pods undergo frequent rolling updates
> - Network policies and CNI configurations change dynamically
> - Low I/O latency is critical for RT workloads
> - sync() calls can block for 120+ seconds waiting for reconnection
>
> This patch improves the situation by:
> 1. Detecting EADDRNOTAVAIL on both IPv4 and IPv6 connections
> 2. Using a shorter retry interval (100ms) instead of exponential backoff
> 3. Logging a more informative rate-limited warning message
> 4. Supporting both msgr1 and msgr2 protocol versions
> 5. Clearing the flag on successful connection and when reopening
>
> The fast retry approach is appropriate because:
> - EADDRNOTAVAIL is typically transient (address becomes valid in 1-2s)

Hi Ionut,

I'm missing how an error that is typically transient and goes away in
1-2s can cause a delay of 15+ seconds against a 250ms, 500ms, 1s, 2s,
4s, 8s, 15s backoff loop.  If the address becomes valid in 1-2s, I'd
expect the third or the forth attempt to succeed, with a total wait of
1.75s or 3.75s.  Can you please elaborate?

> - Each retry attempt is inexpensive (kernel_connect fails immediately)
> - Quick recovery is critical for maintaining storage availability
> - The connection succeeds as soon as the address becomes valid
>
> Real-world impact: In production logs showing 'task sync blocked for
> more than 122 seconds' with error -99 (EADDRNOTAVAIL), this patch
> reduces reconnection time from 120+ seconds to 2-3 seconds.

How many attempts do you see per session (i.e. to a particular monitor
OSD or MDS) and in total for the event (e.g. rolling upgrade) before and
after this patch?  Perhaps the effect gets multiplied in an unexpected
way or the backoff mechanism isn't working as expected in general.

Thanks,

                Ilya
