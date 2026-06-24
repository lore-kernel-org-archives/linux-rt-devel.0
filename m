Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC433C6A43
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317684; cv=pass; b=Hu9qyXmeyhMM7PHVuvSW2Cm5eoY+NJTp+P0BnGYPjg8gweGqLbaL31JLaCs104GyhZASP7dW7MdR9xX43lLowXIfLQFTaEyvm37317JxjD2D15NCvxeyHkeRlrKykaVPtV42XLMCFvIHbqXZC6LP10jV/78L6bVGIbLAR+b5HoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317684; c=relaxed/simple;
	bh=Sdzgqtv1Tmlni/DBclt3F/1Zy3gjhyQWqH2lmWCayf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbwpUNdeyLTv9Cwe6uHigoZisNa1YH7NAOJP0VzszSnaPHjYj0/gLuhTsxtar8gZgYdkzOETglmfihnV3IGbUmNQ0zZOE7J5pOm8Yz6yzYyL6oiZWIeolbj4zxznLgD0cUh1Xlrb45HpRqDqMO0bo3svro8nVF+JZYoS+7NO8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZB6B5rek; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZB6B5rek"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765331535so296831cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782317683; cv=none;
        d=google.com; s=arc-20260327;
        b=WNrZ9QftXPxHyFzgnbEXDwEIDmWFcv7me01ul4PsMjWn7WXMja6T64IPaKyZhXFH5n
         2NqOdlAOwWQNqht3b1GynlvZyuKcg5vmi6Meey4ptB09wi2wwwo7YplSpDLV6JbJnZBx
         XZNQbhoB3EElITpdywgfXnpiB98Hc1IwD7oMeU2ASootgH9TSrvTwoztbqMoFL7Qiz+L
         5pQ8VcEGAwkt0qdJxM7Cz796EAqEA6JK4qtqCp8l09BS+K92yPdTEi5HezDlyJboDWe4
         yMzRDdfM30qm08ney0UzTF6ZZvzNmjXXAJCvFGyIBKF/yv3GY4Cr2Npnpbzzb31Bd6VM
         QBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        fh=c53CI3WbDHriSOefqa2uP2m215qiap1j4g9uTHW6MhA=;
        b=PhkwQRsjMoV/qKJ1f+ucMsEFGCmO1kg8zrZDQdMD6qo5BwdrI1EcQDV4gPrRVbtnxI
         to/E0unDIaQXLJakTbSYjJ1d3eSSwgnl1Ipn++OMfbKITMklIefM5wj7M2kL5zyMTtGW
         BN0/AbgRhBG7RB/9tuC8iqrz4N2isu2Y/VUssw8CsFQsYMoU5CD9q5lqDZzpuQo/4iIb
         HXfFsT18WlLbjd8aU38g+4AyFuyQVMD7637R66qqdHOj3W6Z/TZ9wENlNJPT9ZQUKYHR
         IbJOFcRWEsDxJIoo6lfvcTrYdiH9ys8Rz0ZFGoMq5GLOWt8fPiiHDo+6TeWjEiMz54wx
         TBhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782317683; x=1782922483; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        b=ZB6B5rekOxw2Ro5L5XtHaUgOTZKdLwFlCyCwT38siH+JndQzZ+t9Fa9GUC80M0I7oI
         yb6/JV5sFu+idRkQgVCWlE7LfXlnlVSYBYTy+kz7RE/fV+mZvufaiW7ZwgFI0lb/LCBz
         t1ZtM0nqkk0prhq2FmS6BJSlurx0Ek1iQLXtp/DdhJJPJcOSHZFmWGp61MLOy4CJRbs2
         pZAA+reM32VrE9h++nye+LRS8+4rBuhOddoYxeRo3RhFjMiUtK7fRdb6zebW/Rkzac3l
         h9M1D/49HvvemZMqL8yUNUKMs3yon3X4i7qTK7ZrLU1iswVeSUSbBSwOPVKAjCGBpDoW
         iBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317683; x=1782922483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4jqqFTyVaEfw5oQOEDvCjggk+pjLmWqgC46xkeFBNE=;
        b=GpKwWhpCq+TJ7qFcDez3ia/ITXRNUzHadF2l/24uNQntvzoaD7IveNHKh0tZ8n6vWn
         R/hfc1i5z/GkcqS+UZMkr5Uu/CzFeJ6+GPirvJtgwyPheJZQP/62GjrYn5B1FCtX+S/K
         ZHBM58V2Tl3qg2YYnaqX2IRPwTZsaFgfXodEFprlgMqB7pfl7rzUBYfcV1k/uzIVDmtw
         GFd4xShYkWPFCYzixLcOgja0FOHx36zgx1TgjB/BqGpZIiOJyuWlWfCl34ZRAF641RrV
         x5nRWAJr5EUzL5Pp3a6UaOiXYk3lY5jnRYBDaYh09yykHT6kUNCynQOcvxawWOgjR3gM
         JJUg==
X-Forwarded-Encrypted: i=1; AFNElJ/DWKVvNTR4EOhK/Q5+r2tHGtozVI3og9GLhu/GsMh+jl8ecwrV9PrecIseyL4I40FPdLmOukCgO/cvmYOGiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlMlCnbZGUfYuvofTXuU04dHnPQRBhz4wbdPu44xW9A0XOSfTF
	uBimilGZysHpKbBKRzqxjt84hzeisFLeJ26Bem5S2BdnjaQoj3Hdrz55adnP8l/easc+47DJwuM
	27ELpqsmAf232IhoUhYPsRDuJEvI14RG3Tk3Gqgs/
X-Gm-Gg: AfdE7cl7K8uv5b1b4Y4guXQdrDqxVc2rHElMaAX8ccCuaZ4S7RZlcGVrgrgyOljp8MD
	ED0GmoaE/p1R5rIGM9IPHAwwcEQO/C024IqHGRTVTUPspheXeBqQEx3xiG9tBqxnYG5QAnU8mOp
	MAK+6gh/yZ1llSL0VVct8wDY/c3mLznh6KomcFSMho3D6G/oJerq1phsyZoetf4qULCIAb4EsTp
	D7E5NnwCcT2TXceRS7vRm/sA3fAA1FVSz+t0ODJP5SBU+y9+zvn/MoZUWUfMWeqsJeAoycTugC7
	0gwbrsD67/p/nADK83RUc1cII9w=
X-Received: by 2002:a05:622a:14:b0:519:df4f:6c93 with SMTP id
 d75a77b69052e-51a617dba42mr10324841cf.20.1782317681383; Wed, 24 Jun 2026
 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com> <20260622101056.4120C1F000E9@smtp.kernel.org>
 <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev> <ajm_dEqauYLBi-7T@google.com> <ajnTJ03IxVnBXWdp@google.com>
In-Reply-To: <ajnTJ03IxVnBXWdp@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:14:30 -0700
X-Gm-Features: AVVi8CfUZG4ru4sHeWtIPbsYQyBEOrJbLz3f3SZdi_mmHQdVijFR8buxYw7ygJ4
Message-ID: <CAJuCfpEUZ-xL7ebW21Q=5wXDFuJSeh52Ei-8YLsRUdXiB5NiYg@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Jun 22, 2026 at 04:04:20PM -0700, Sean Christopherson wrote:
> > On Mon, Jun 22, 2026, Brendan Jackman wrote:
> > > On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
> > > > - [Medium] The commit message incorrectly states that `__alloc_page=
s_node()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> > > > --
> > > >
> > > > commit 7bd439c242125db27305b61b14c9972fb028282a
> > > > Author: Brendan Jackman <jackmanb@google.com>
> > > >
> > > > KVM: VMX: Use higher-level allocator
> >
> > While you're dealing with nits, can you massage the shortlog to somethi=
ng like:
> >
> >   KVM: VMX: Use no-underscores API when allocating pages for a specific=
 NUMA node
> >
> > "Use higher-level allocator" is extremely vague, and arguably misleadin=
g because
> > the "allocator" being used isn't changing.  Which is kinda the point: *=
nothing*
> > is changing in practice.
>
> Maybe "higher-level allocator API"?
>
> no-underscores is just.. meh :P

It's overall a good idea to add "No functional change intended" at the
end of the changelog in all these cleanup patches.

>
