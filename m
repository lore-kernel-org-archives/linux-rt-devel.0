Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BB2101B4
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999194; cv=none; b=U7s8NMtaSB5saS4TVQ6zynn+nsEIyDXbLQXQPARpUhSIcc5or/0vVadayXrdz0FRG5lZnspJ2zbETjMIqUUiquG/2Z7W/9tqAscydlC4JRVbM1k1VCX8Z1hmBgvi0Sk/cx0HoLmYOkLKBm3WT3QAeV75RLm+7wdTvQmGIMcGhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999194; c=relaxed/simple;
	bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RstGm5Wwn33FS1IL+ev2OBdnUrQEXoRJ7L8xk81v6jSSeIIX04QXb6o+0rK8F5N9XhGupGEQCMY0lvO8cTPcKwylw1GbQzSu1MIKXeRwVljNRikgz7ygijk+e54GtUguQ3Rbnj+A0YcgMBzTdGbDiWGrKI/19vtU5JnI3qw8q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SBmgZv5U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SBmgZv5U"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa66ead88b3so75454366b.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733999191; x=1734603991; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
        b=SBmgZv5UF6aKIaMv2Uh/xIOGpk3zq57R6zZynEDguKCn9efMyxSB0sgrxmuRAEe0Bc
         Fa5cJ7P4xhFqpRs84uNdIWKlmVr6QKIKNIkc0/HbNCM629qhcKRztoDTlzh6NA+xO5cp
         uwVjJ4BYGmZMZE6+G7UsDZ2PFFqS0q0ttv91FIVk9HIymLytVP9go2lsJSU+tUucmvTY
         K2GrawXOTZxGIGYp52KqmkwClddJcIaefLfIMg0wswCMsLenXcrkHsJmPmhbID05/RgX
         JX+TycxfAeaHedKp23fcLa0jixJ41FMHrpwYpZhb538IZsWZ5bcwiHBLoiIjR2hEDAQm
         +owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999191; x=1734603991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
        b=UiLoWJ++A5bUxOIGSl/1DG0/t6p5j0wGEj1vDxrcwb2/YHFYqihHIW9nk9Qakn+3d3
         rj1L6802vM2b5zXFfwUznK5Am7huEnv/Ea6Sz6ee2wOlvEGDR/7KZt/OERkEQmnYNEZk
         ewV785nHzJIutpd76BIJjnlZC6Bq6ue46JtGliw6DMKrn4KYqaVFcoKbGPXLemtpNAic
         /KvjzzAxxZaclAvbIxKj6d9r2L1BJH8ReBX1mZsz9MbIxezrf0QwqIIKmopj6S7dideh
         YZR8IAPlpQCv9Q/VzcfTRmeixaYU/0V61vm1L3Khp7715VAB91bHdlaRae2k4XPcdVbN
         WDHg==
X-Forwarded-Encrypted: i=1; AJvYcCV/lU+oHZxeHzSYtew+GEUNkaahOyUnXjKWGAFstGrqy6Kyn/WLAtmA7p8v4pngGUrBF9B+DEcNIAFQgJnJ/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3UZ/8hxsAqXez628D2eWKeYJ/0oRoD6P1nqSvtXAx0bF17UEr
	H9Q5WkvGYJmW+SbUvq/AjZzWkLJ/HDm5Ft7PT+sljQAs09Xi8lmnVq7dfn/Dz/zsgZa1LR6iZ0q
	dMl3v1NLnBD5/EsZ87aH/+06eJpS53unMSI9Zkw==
X-Gm-Gg: ASbGnctsnPJkHZr2KYdsW1VUNN7cuJHqM0DMr5oNrszUswQsVqwCErjntfSmSy0Ya0Y
	SiCm1ad2lcI7hPjlidQVfByjMwaKSYJS84zNB
X-Google-Smtp-Source: AGHT+IH5yAN/gbiLL76Dk6LGA9jPui58kjRG4i8N9veQAZCoYkURqjEfO9YzuGA80yAQIDSiR81lnOHnHecPK3+61BY=
X-Received: by 2002:a17:907:9548:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-aa6b10f5f65mr510217466b.2.1733999190969; Thu, 12 Dec 2024
 02:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com> <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com> <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
 <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
In-Reply-To: <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 11:26:20 +0100
Message-ID: <CAPjX3Fexb19AcchSttsmm=JCcobBBCPXxF6_qkK=_yuqtgNRRg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 11:10=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 10:35, Daniel Vacek wrote:
> > On Thu, Dec 12, 2024 at 10:14=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> >> it is now, sorry.
> >
> > Yeah, this looks very similar and it should fix the bug as well. In
> > fact the fix part looks exactly the same, I just also changed the
> > slab/stack allocation while you changed the atomic/refcount. But these
> > are unrelated, IIUC. I actually planned to split it into two patches
> > but David told me it's not necessary and I should send it as it is.
> >
> > Just nitpicking about your patch, the subject says simplify while I
> > don't really see any simplification.
> > Also it does not mention the UAF bug leading to crashes it fixes,
> > missing the Fixes: and CC: stable tags.
> >
> > What do we do now?
>
> I think it's up to David if he want's to send the patch for this rc or
> not. In my test environment the part that went upstream was sufficient
> to fix the UAF, so this was the part that actually went to Linus first.

But it (I assume you are referring to `05b36b04d74a`) does not really
fix the UAF. I'm still able to get the same crashes even with this
commit applied. That was actually where I originally started testing.

> @Dave can you send '34725028ec55 ("btrfs: simplify waiting for encoded
> read endios")' in the next PR? I can update the Fixes tag.

The commit message definitely needs to be updated mentioning that this
actually fixes the UAF which `05b36b04d74a` does not really address.

--nX
