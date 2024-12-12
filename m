Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453820E02D
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993613; cv=none; b=XRkI2qIOWUXtb86KLSpAg4WOr0oS/e1W28G5IB0qbVWBreU9PiViD1bXmvSIV2LoWOT62k1SU4RQIL4WaczHvwONf0j9dt1pBPsV2OartdDlnv3ePLFOnngDBYsKp3VjWvxCTyxqkjm1SQhnnbbl2dFJR0P/BqDV5TNMZhxBxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993613; c=relaxed/simple;
	bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVkpcBh3IDpJ9Aq0nXvQHql64RwGn17wTHg+zfrgdz7XOHs6vBf28oyXoiD8SOi33hIC1hc0Fu0EQan63KFij9fGxyC9pViaPFj7+ojnJma7b6jK7oUCnSzr8UtW/IcuuEh9emcmah6htH/7ELWQXMUk3A5/ugn+JsYSWu0Zq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IqWSCvSP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IqWSCvSP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67333f7d2so47487766b.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 00:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733993610; x=1734598410; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=IqWSCvSPmyyFVWRVJdsGM/44gZWN16GTVY7ieLFqJuBCVRqhqklo8Lv601TI/Puq1s
         /2KkM0++tU2lhYWlI/ki7aOIU4Y9YKW52sYs0T7FWXt4mbcP35/vcBvEBVn+rNX5o8CD
         48zzJ08i8NNiv3+h4FLV7SlAKWSO3VKEoNpEh+h9UQPm6VsaRKXxQkqjxxuW8+dmKS2t
         hN+zt0e9EPGCK5fjC+pSpPMeMI2MZ/jDOnLWZWwqxIcwTFe9QT9VlOrgwipHxoiueB6v
         ig4ByIIKp7SKRiiAIBtfhwtMMXp+lhf+2obKIjs64Box+ol3HWYGRjCPm9FG1KdNClqV
         1Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993610; x=1734598410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=Li3xoyCFpNQXcdHDTT/rnUZwlYHADGYCxta27ED4QCWrUFd31Urp7RVGy4j3BQIhqE
         AQjaoIfg4K1pLHNEgcgyOy7sYpNnmJaoVLIeh3AIl3ZHH7qoYWoPsXrcfGLgh3OsbRRa
         3sUhpVWihhdEDGkBhCjZbcrt0qDVIORyZ7n0mN5xSo3GVZdhHGYzbzZKZQjzKBeoMpGe
         jntBnL4L1X1mDyFIHUSvSe6D+rBTsl77sJSO0e6lGAJzhx4KMDz6Pjf/fKN3otzaguTW
         Zp2ROdCL7sOqwegNjOXvBjmVZ3EYAK/7/AVCHno3q9LOHWZgvz7AXbJVoYBLumtyE/zE
         YIkA==
X-Forwarded-Encrypted: i=1; AJvYcCVKI1GTwuzcSyiFlW57Xa/QeQtD11LoguX63+hVtjafiqimfDV/gKX+VWc6TNxgwwyLT7It/yBCsyAx45Purg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQNTMOgl0SnFIXsEMl7+buplSAoyjiieOcqRA9LrLT28ZIppMC
	JNW2RtRu4sYd57xdtpdLSuwa55HCXOVC2Pb/z94yOM3/7tht5VCzR6wW68+sdCvI3PPfwyxQJ/v
	uisRtWS3/mbhdk+dc8KRIIHP9D7+ZAzbRLZ0NQA==
X-Gm-Gg: ASbGnctINYb6VEeMrZBbzb+BwNcJba8UadSEvXp3tF6lTG8kZXMWT4R7bjd8gzx6U1Y
	0cf58Ye7uuSpfvZyIIGuNSmYxFkPPENnFTadr
X-Google-Smtp-Source: AGHT+IGfU6rtOHJOHdj57SSVfLI9f6Fq/2KuTXoPZHJiIsnpZhdomXumhthcwf+ID3geTKkQc3OpcXoAOkvCd9M9EK8=
X-Received: by 2002:a17:907:b8f:b0:aa6:a9fe:46e5 with SMTP id
 a640c23a62f3a-aa6b13d1a29mr485360666b.53.1733993610333; Thu, 12 Dec 2024
 00:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
In-Reply-To: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 09:53:19 +0100
Message-ID: <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:09, Daniel Vacek wrote:
> > Hi Johannes,
> >
> > On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 08:54, Daniel Vacek wrote:
> >>> While testing the encoded read feature the following crash was observ=
ed
> >>> and it can be reliably reproduced:
> >>>
> >>
> >>
> >> Hi Daniel,
> >>
> >> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-free
> >> in btrfs_encoded_read_endio()")'. Do you have this patch applied to yo=
ur
> >> kernel? IIRC it went upstream with 6.13-rc2.
> >
> > Yes, I do. This one is on top of it. The crash happens with
> > `05b36b04d74a` applied. All the crashes were reproduced with
> > `feffde684ac2`.
> >
> > Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> > does not look to deal correctly with the issue to me. I was a bit
> > surprised/puzzled.
>
> Can you elaborate why?

As it only touches one of those four atomic_dec_... lines. In theory
the issue can happen also on the two async places, IIUC. It's only a
matter of race probability.

> > Anyways, I could reproduce the crash in a matter of half an hour. With
> > this fix the torture is surviving for 22 hours atm.
>
> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> read endios")'? Looking at the diff it doesn't seems so.

I cannot find that one. Am I missing something? Which repo are you using?

--nX
