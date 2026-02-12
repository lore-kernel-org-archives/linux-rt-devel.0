Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234E1632DD
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Feb 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880229; cv=pass; b=hC84G/31LAFkSA/MDikAwjiQTONmpYA+a6CdRruyGungqx4R2eladZXaETNI+8caNfSIf44fJyqt5CIawShFnXh2Hgzkl49ZsNji5MRTm/4dIwxQzYdIrXzy9AijWq+6N+1Vy0UP+3PD5o1UDrnLlWqRaViFOh3DNlUgC/QNgIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880229; c=relaxed/simple;
	bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SclYLxLqO+QH5+c5Ewj84LpxVb4ccevrvd1PqtfPPhxnzTeb6dWar8yD2C2QIuX28B13xPUA6uLMqjK1/GuJpbBiVqYG4de/EFAnuaA6dnpd0R6gOHYdsL3RT8N6WMxwVt0CUuN8OQ0GgNe0wkFV6Qq+Q5QuimFjOYNP5X5nQpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hg6Y6IG8; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg6Y6IG8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927261a3acso64136287b3.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Feb 2026 23:10:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770880227; cv=none;
        d=google.com; s=arc-20240605;
        b=LSBU580vZeOFez+FvpgVI292CtJqodilkp2ry2y+2p6KHOfD/2Ez2uTWBQQbZkW7lo
         cKEmK8Syowq5joR8oKuS2DT+6iK2pFYYIPHU7O72E1iK+VLEy12fBnWkGIWu1epXldge
         KsBjTLxWeu5JO5UWanvKdC2id3x21/SKn56JWrJU/K1FpNTlUY2A0uqOa2OwphP1w61s
         M1ZyiUBfOaC/xVcw8A971B+fPGDg0k+jMcQsOo58rUeRoKfsHq7IMxy42Cxu6liQE0DW
         OdGBDa5duR18Jus9LLWkqvD4x0PWxPwP4B/L7KVs8wToOdtiZYvN1EiXFoKTE9CVMFEM
         IrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        fh=bZGPpQxdrMho4RtBZ/V53SjJCp1nz81QI7Pbn0zg7e4=;
        b=lFxwUBOk+LAHHno0tRRNdCOfJwRQuruk+erJwzKyEfBek1dG9DrWR5tgkXcUnRVU0j
         gBGFoOJogy3gP/eSGdvK7LANRLJv3OSHASdmqNnW6tnZjVffA59iy31TFtMhZrbziXwE
         8BM3Tp5s23j5FPQYEPXgtT6C4HD1jOwC0a5pu96yrgwnYlYp918YeQ8ksjvVXvSzBEH/
         oB6DkCMwNCzvFjshee/UMJbeE0U/hdZmWNnw3SNI6XtieiDDyhC3D9nR4yJ1jZDzOKRV
         43UfrjRZt5LuSzcJBLDUcrOdedqFsBFiG0C3FkVr3oOUK2O7hXIXcPXK0+asfdrxe8FZ
         a4/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770880227; x=1771485027; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        b=Hg6Y6IG8BJUv7PQdiFvkJlYMxmLeuz2BHy31z75OOXXRpcimFcRSs8TxNu59DENdJr
         +JQk8g1IMp8q12bZHEwTG4wDLaQK1IFv6G/yfD6cFlXWETcmpVxU5fcUC1Y70f9GoMD6
         YJUvmfq4eTzu4LO52jOhHx+ygWCnS654kVNobQKrnfO4KpnE3xdomgpb+qYJE7V4aLFU
         H/RY7Jxi0sd1iBJPzec/vr8UqvDcBYC280sJTIPaemuJmqtGJ9XV3wHiv+2dkcKvy66P
         HkD6z/HuFbOlqqZTK5fFpFQ/wvHn4Rw9MGTZR38hPGBLIz06RhHpCIqGrRO39CP14oIR
         nPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880227; x=1771485027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KG6yTYpjbvXJt3wBY2xUXuSYRR+NsyO1kX+qanLZH0=;
        b=XjjMq0pyCEOjHV5ozGILPqw6XywK4gQsMOCZ8TY37YSARA6onsd+ceFmvfNXhZgDy5
         tzmP7hCmD+3Xp3ORg+mzyB95kAXkHilFlIzyBPDJx5l3KgRuhHS5yPdtb7Pra2tZ2AdH
         DhERdIydk0CW7723VtShwJZ7n6RvVZbe74tXdjw6F1TSkZmG2724EVt/+wGwHgnQD8O4
         nB7c9g7cHDc5XVGQ6Dcw8PcbPhV/gZ9N3ZkruubohvTmnxifPeB1sYJX5C13PcexkhW/
         YkQCCenUGm1Xfyo8g8G3yG6o2YYUKafxEP88ntPCcmg9U2JDBIcdvBqBTKTsyK6qULQx
         LF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsLTuma/Tpz5rGykIVlb/R8ay9m9ESp5DOeFOOvn9boMgoZ3uw0tPLgPsALLKM4aAeCjIHJExrvKSaPd8UcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL+UYmPibgt8EhsRkKJUhAO6YAP47d4ghR35T/pbMKZTVeS5ot
	tjpu5WfxnYev8CykQzts5rn/S9t8RJQshuJlSK5AoyANrC004m5BbUTNY9dyQ/WDA0nntIsJxNY
	6EZtRnHQUgI7qEXRg0nIMADzfeE3CN+fNUheBNePRRg==
X-Gm-Gg: AZuq6aJlAK7H77rgI1BLSeNQa2bJGpHHjgDM0nds3BUD0vWLGZDX7oM6rqQ7IqHVVA0
	KNqnTNMVY49XPqlCLYpLrIdVlJnjIpFPDiVqEmgCLdDYqXUfUm4HRLym+LA9C3kAlOIBVgCQhVW
	zba5yBjxttSHDh7Tm6QNVkeLTqTrQ6PpAs32aWw7TMJUdZLHAXH9Nxt5G2OjExqRi3MspFbY2ma
	qKgNV/KC/AZ2RtOeztr/F+P0l1u7KJ5u00X5iQIRRmZnZ69aLJgJ3LyiK8HOokWuBRnueOliD1J
	O8U/MHTJDRmV1HkbCXziD5JM4b7uz8T8rpuPRd5bKNJmCQcS4P7Hq5jWiabqf9cLWMzQ986WJgO
	72x19DM/03Wz+ONkT20wPEymQWdxB4Ww8nq3AEMEnANNIF9MhTHU4BcIZEo1YhbxM4f0QG8WefH
	p/R25Zv/jt7ODwITkhZUEpDR2jGGWINmmW2W0WGiltLtq3aM4np50TX1X74siugJZmP/74bDpvY
	SKPolXWr0KOJPLbILi9jIyE4kVixlSSimcj9Na3JTQFqrM8f8OeVkeokByn3s6ZkgTdEdPifgxK
	U3ZQERFFnZi6JNrFHrbCyqxMdtEBDiNw0QNQndjAeHsf
X-Received: by 2002:a05:690c:d92:b0:795:294c:fd5c with SMTP id
 00721157ae682-797377c6342mr21105127b3.54.1770880226856; Wed, 11 Feb 2026
 23:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com> <20260209155528.k7RMRPVD@linutronix.de>
In-Reply-To: <20260209155528.k7RMRPVD@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 09:09:51 +0200
X-Gm-Features: AZwV_QgV0EeSzgexrImustAVkDXwmMOeACoWIeW_o8NOkYjmco0xL_-FUB4iv7A
Message-ID: <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

Late to the party but ...

On Mon, 9 Feb 2026 at 17:55, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-09 12:17:35 [-0300], Luis Claudio R. Goncalves wrote:
> > Sebastian, as for the TEE feature you mentioned, is there specific test I
> > should run? Or is there any test you would like me to run in the context of
> > this change?
>
> Puh.
> If you have a TEE environment, then the EFI interface should be
> "supplied" the TEE instead the runtime-wrappers. My guess is that
> tee_get_variable() would be used instead and here the workqueue won't be
> used (I think). So that is the easy part.
>
> What I don't know is if this is a problem, i.e. is it possible to
> interrupt the secure monitor and continue in Linux before heading back
> to the secure environment or not.

In theory yes. In practice, at least for arm & OP-TEE, the
communication between the TEE and the secure-world app doing the
variable chekcs & authentication is via the MM protocol [0].
IIRC that requires to run to completion. So what happens is that you
enter OP-TEE and right before the StMM is invoked (the app that
handles EFI variables) all exceptions are masked and it must run to
completion.
The period of masking does not include writing the variables to
storage. That's handled differently and is interruptible.

> If you could check how long you end up in the next variable and RTC call
> and if the time is noticeable, do you see it in cyclictest or not.
> So if the EFI-TEE-RTC-callback takes always >1ms and you don't see this
> in cyclictest as a spike then it should be good.
>
> Sebastian
>

[0] https://documentation-service.arm.com/static/5ed11e40ca06a95ce53f905c

Cheers
/Ilias
