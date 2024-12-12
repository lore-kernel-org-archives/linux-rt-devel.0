Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EF13E40F
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994500; cv=none; b=dJb6f7V1iRT+0vFH2eNduFxj+xoUlOH3By5M16yei6D5Qu88ciYdVJuOjWKJwPLDv+9tPBjSGL07AjHqXEaX2/2cKSBECXvHyHbTts21TVDR+RertB9RUARm11Fk9hhJYBIg2GugaEV8HYlpKcWjxjE9ogEJsWviiJ+Gk8nbxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994500; c=relaxed/simple;
	bh=7mkNhNohCRInUoNEgtBbSXisKCJhOCIqilr1bctY9qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCcirTFAe4qmfByJhpa6IMv40UQfLoVnf+9eQmkSWgDzWnKEYwGCqNq433LAZ65pENareuGPg0NMKlJTcVId0j3g4QCVQAxSSjAU3WeQG53Snyn/bj00AKGqpH7KX709dVCjTjkhIexRZNIYl+g9vCzLgfiAYElEDQgXscHPzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U2rQaSlz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U2rQaSlz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa69251292dso64438966b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733994496; x=1734599296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=U2rQaSlzhF/IC1p+VDzkXoOi2WLmL7PlQO+BZorRhQj1g4PMBPkUtkH4YuVwQYfrbB
         9senAv9w3D8aXa1Uciwcb/hHuw4l/afk2u+I76ou8wuepxpIQjxxsjJuRjRlS5+V+orZ
         g+6jJYOXZc6bzuG0rbu/X0R32lFCzV2RFruqO1tYSUd68EI9acJcL3TAbrceRZJ08rgC
         AHszzepgHOZ4pTb7bluB1nDOil8LL/m7TTvAMlfKA/CETiK3FLAKm2ogpwtHuPJASkY4
         A5ub8q4HMRB0NAUFtpQhy3QwKfe0hhy41VlljocHZo7dCkDQqW+pApmYWO6Oc4OwynLL
         qA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733994496; x=1734599296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy+XHWudhy1v5FQx+HPpD7u/EehmML+tWjPRArge5Pk=;
        b=YRKBu+E05XpKMuHDJHsXGw4EagLy1b1ro7z9dJ74hLmueImuN3HHEy9VrdbcFTjZxa
         +b0jY7RFY/fDO5x42Wra/x7UjlsKe8yeGGMPaIvWSFFR7ozDNb6swXXmMdkUwOglG4P7
         fts0M2h0cTse1nWVxKx33DLZwZlcrtpuzvdinlje/mi8sbgzFw5eGgq5uw8GMncX2800
         1jsCh2+YWh0GogKgaeqfITmQkWiprkUUUSbeTEndCMYBgENh8iIlLAY3pOFOJOwhpBAJ
         afvfFX4waitMosB9Z5qzxEo2RndfIJzTQbgGsmX4rX95VfX5eUoHjBtz0Y8d55KGELVU
         w3lA==
X-Forwarded-Encrypted: i=1; AJvYcCVzZizis9JM7SyvbhiMUGW8ZECV+S1tLzSL8UPysxgjRo8PGSNnNj5zuCLMPaA3CR3HsHZ9W0LS/URlIpzUtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCfBuYr1Q9Tp1/4PoBmUIvB8y7QiPHutUzj07txowCnL1PLsXa
	rZ67IJTmYg6Gv9y5VeU3kYA1nzg+L+g2aUnQW60/oIHKjd5d0DCMhrEFjviIZBkMyqgJn+ZmzEo
	QDb7S2K2ioVxt5dRx4UIAjhte0eWofIQt46ZYrg==
X-Gm-Gg: ASbGncsUO85uCPCTRvAQmJT1XATpQdjyis7FvlMx2nZybEY3PqwaL3V+5/g8hsJqoOc
	hSyjVd+oHA1qsyz1F8B0DqS1ds93MdXM8MKWu
X-Google-Smtp-Source: AGHT+IHEeJ3cn9fsQUrmcRwGKGFNz+w9xyhYxVnY2x3y6VbhboijLIDasxIc1jaQaLdp8+eNSrWDe+me41Cfc3kAJW0=
X-Received: by 2002:a17:906:2929:b0:aa6:8096:204d with SMTP id
 a640c23a62f3a-aa6b1141caamr537934766b.3.1733994496399; Thu, 12 Dec 2024
 01:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com> <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
In-Reply-To: <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:08:05 +0100
Message-ID: <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 10:02=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:53, Daniel Vacek wrote:
> > On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 09:09, Daniel Vacek wrote:
> >>> Hi Johannes,
> >>>
> >>> On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> >>> <Johannes.Thumshirn@wdc.com> wrote:
> >>>>
> >>>> On 12.12.24 08:54, Daniel Vacek wrote:
> >>>>> While testing the encoded read feature the following crash was obse=
rved
> >>>>> and it can be reliably reproduced:
> >>>>>
> >>>>
> >>>>
> >>>> Hi Daniel,
> >>>>
> >>>> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-fr=
ee
> >>>> in btrfs_encoded_read_endio()")'. Do you have this patch applied to =
your
> >>>> kernel? IIRC it went upstream with 6.13-rc2.
> >>>
> >>> Yes, I do. This one is on top of it. The crash happens with
> >>> `05b36b04d74a` applied. All the crashes were reproduced with
> >>> `feffde684ac2`.
> >>>
> >>> Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> >>> does not look to deal correctly with the issue to me. I was a bit
> >>> surprised/puzzled.
> >>
> >> Can you elaborate why?
> >
> > As it only touches one of those four atomic_dec_... lines. In theory
> > the issue can happen also on the two async places, IIUC. It's only a
> > matter of race probability.
> >
> >>> Anyways, I could reproduce the crash in a matter of half an hour. Wit=
h
> >>> this fix the torture is surviving for 22 hours atm.
> >>
> >> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> >> read endios")'? Looking at the diff it doesn't seems so.
> >
> > I cannot find that one. Am I missing something? Which repo are you usin=
g?
>
> The for-next branch for btrfs [1], which is what ppl developing against
> btrfs should use. Can you please re-test with it and if needed re-base
> your patch on top of it?
>
> [1] https://github.com/btrfs/linux for-next

I did check here and I don't really see the commit.

$ git remote -v
origin    https://github.com/btrfs/linux.git (fetch)
origin    https://github.com/btrfs/linux.git (push)
$ git fetch
$ git show 3ff867828e93 --
fatal: bad revision '3ff867828e93'

Note, I was testing v6.13-rc1. This is a fix not a feature development.

--nX

> Thanks,
>         Johannes
