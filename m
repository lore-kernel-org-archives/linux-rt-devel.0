Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27820B1E7
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991405; cv=none; b=GGjY+Vo1LnImAzviAa5Mz+fHf5FhaPFQiEX8z8qWrM2peCbq6wSBuFvEdGK52XVM7iUO08eG8r+sJWC8zY/LV38SpjGt8H9X9vZ7nVTjUmUUFEUKIdVH5B6wGOKxZ96OVB0Tq33NAYJonxSmKzmtg8M8kR46zbJu8uMXQKfH4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991405; c=relaxed/simple;
	bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbPO16mtOWJLiztdqmFbp6LfKVBZETROYwzEtc/5SoQJ9sV9HfX0h3W84KEICvM7heD4qphEOUeLfoIi95bGdqOv8Rb6c+27CNnFl4L71rJuu/nTrIsEAqzKIVl3b8QSivJjTyvL/w4iUuI2w6F1nCqp7bh4sMmZEDQnEGa/NCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AdnHU6Ke; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AdnHU6Ke"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso369654a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 00:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733991402; x=1734596202; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
        b=AdnHU6KeA7/DrsKfwtGhLm0nPGtbQDlTmADRyiR3LhIHmvqfGwPjXJA2ysMmAqaz1J
         /LaCHpASgudsg6Gb0zFc4CFVQShx+FXtBdRqcU2u27thjHNGH6FJ5Xb+/+/l/jLgY1Z0
         zHMnaqRRjDeQ8VH19nJFUnVyELxFp5UsDnYct2L+BngiJES3zCbBYQzHRlb6kctHQ+kU
         tGiTl56mqKuvW5Pmz7fZUlE+2FAodA/5Dc3UlArNriZjJ/IgG5fSRKC/qXITjtBkSaAN
         Hx/9hf7MczXNoNs1Qdgc4uIbpjq6bjs0btee+0Lxs489pYTEOj6xadOEbJv2JMw47yLP
         k04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991402; x=1734596202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
        b=Nakn7bWwFLsaIQJc+ukaaMuqifdf3DKyGMRCLLouIDnrZfx7thbS//P8FkqCIlhur8
         Z0K4yW1Km/tDjE3w0PiGfxsgId4XrHetcTvqnFEkuI+643GEML2/kXP3HeNO3m2zXA1r
         3oTnO1lUF4Wet10Of8qp9YpOdcCi4BO6nVg0vsZb6YpLyhjgpz3/0THC3SmdQdNRRFMK
         8bs366XNCVAWmIVTAcO3/tz9+II2aTYz+reT8aTynxPPH8Dv3/u8os921muKZEQWvw5S
         YFfNrqaw0aZEVD990iG1n7hh/XVxyNTJ6NmVWys/KPcx5ITpza97fw9FNfRrJxfEd95y
         bXTA==
X-Forwarded-Encrypted: i=1; AJvYcCX/rz1e3WiROvRm7yKj8N6PXDmJo0MBk10ROCcVHhcIIi8hTKD1+eAD7hDRzInTj7QRsGrK/3n+QeOdGxAI7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvuBpaBj91Ly6AevDmLhu9jkWXCdL1Uw3vXrEsIywmME4UOlyn
	WXSrxOta+lAi7zAlogYnh4VjMAd66Jm9cLixH534U+TwKirmEstQqSzKz1MQFqRBWv2Q+BtVNFF
	GPounIW1sDE+T/YwlW/Oc18VEtZcg1eUWPQ+1gg==
X-Gm-Gg: ASbGncuxWpbLwuEqLIp4/l4qeKVO1/mss+3tC//Xea+Q2eU4UjnPdehi3OlOymWaDfu
	/3Fa9iAx0Hz57lRVrd0bQ2N2QZTtpKJKfLrQT
X-Google-Smtp-Source: AGHT+IHq2LiaTDAdQG1IRxOtsTssjhx6LklAJX9kMaulofgK7RHDp0nhYM9dwMoslUBNdUIH+VK7eMST4iIte9mhc84=
X-Received: by 2002:a17:906:3083:b0:aa6:8a1b:8b78 with SMTP id
 a640c23a62f3a-aa6c1ad9e4fmr273362366b.6.1733991401684; Thu, 12 Dec 2024
 00:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
In-Reply-To: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 09:16:31 +0100
Message-ID: <CAPjX3FcS55T_qToJqSrHJ3NhMtWFU86wE-qk1Khpf++MvPqzyA@mail.gmail.com>
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

Hi Johannes,

On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 08:54, Daniel Vacek wrote:
> > While testing the encoded read feature the following crash was observed
> > and it can be reliably reproduced:
> >
>
>
> Hi Daniel,
>
> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-free
> in btrfs_encoded_read_endio()")'. Do you have this patch applied to your
> kernel? IIRC it went upstream with 6.13-rc2.

Yes, I do. This one is on top of it. The crash happens with
`05b36b04d74a` applied. All the crashes were reproduced with
build of `feffde684ac2`.

Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
does not look to deal correctly with the issue to me. I was a bit
surprised/puzzled.

Anyways, I could reproduce the crash in a matter of half an hour. With
this fix the torture is surviving for 22 hours atm.

--nX
