Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9720E318
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996101; cv=none; b=ONk8orEjHmq2iEsBDLgkv+gqHcm84y72fFC0/JHiZbyAzTC/tdndnbokaeLb0VI3S2JSCkNBQkkGYiAXMIO39k8UOTEyCv52OOu0hDxT9U6mDySve3QqL8XyrZCU/enFwkPm+rM5nKA23uU1Vr1SGTP48qe/cDSNEe1W7PrO+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996101; c=relaxed/simple;
	bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX/uevPII7ga4xCZchcWnomW+O/nJSHOv3hHVGFNn8wBE2/gNovUqMfVGa4n75lYC6KRaaOCDMg5bzIG7ZkCFpf3uPy9+gW2+7XVPrAeSbblTAHtU+2dFgez7esFt6hMDsbT6gQIOvf+tGi2CHzxwpcAWe2F8u6mNMBhztOBrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oua7cDZp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oua7cDZp"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6aee68a57so55857966b.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Dec 2024 01:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733996098; x=1734600898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=Oua7cDZpln+lpXtUaFALKuEtBsaj4aEhDIPzyDzUp3J7ha6XPskPE0zZ2jAexcj0sd
         E0a32phOXYw1/I3ZJ9AovleH6w7WQfGDwb7GnhQHYh1EVZWcBi/2G+xVWMgWHc2EWVT+
         OFVZtsMCqIAvtZohyp4KKuOEbPhddVg3xXChMvS1ofhWfrS60vJq2+PZHIhXYh/rICrn
         aBL8aDyKgwtq79kzJ8fz3PKu6mVxp97IptnawbP3mFhmy5ZMuUTBcztBJs19KE/mITKG
         MDahPuDkjSssLu5n79KMcgWcGcR7KKK8SyWUeOWdL5+jM/JspvKGROnl3DBZrc/KRoqk
         Y4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996098; x=1734600898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=nC46W9MORiQT39i2P2l1qxCgD/2Nokhtehr1C7eu6dBGXXDZmFwBlhNqy9EP++RBoV
         Hw+Rd267JoqXMzbAD5P1YD33cdX93JIYid4GZL5sVV14jPv3e6mhtvK6QMEVRblxKCo1
         cb1MNMLus5Kb2L51P/DArDEghZ1+Vajp6xHy8LOY5pUleIqtb/+lNfwtuURe+3xFCMUs
         uuIcMB0M3XPMCdlKioZEAjH4U22HZZmv30Id+zaQaxfXH6xK++/iSzGjiRzQGKhynRi6
         AoXzdymzPlux6Rp7A38arUJAGFXTtckcexO6p1CCPkOC6nlMf18G9yrDdfr+ydC5kYIW
         QYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUcIr1TNfi861oWSeMvjKqkTfLyhVXdVgElLOm5og4QL6HVYuhlFhNOXhHmPNEBtTMwMF3nDsUiCSqY+cEtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9Xz3XxLxcQcVJ9FhllPDgeewrd2vvM113QhOFU0M8aRIeUkjV
	kr+Cbmy/5fnUCk/DUsk4CE1Wl9cBma2mZb30wJQ7ZgL7vJ9LjDzKa4Vl2RQ+Md/ZO1i/yaFtV2q
	NgFWimtcJ6LwPY8WSES33qs1FVgiQIa0L/gwf+w==
X-Gm-Gg: ASbGnctabDHMa/WWxWWOrIkrSPRjK22c1lfZ3fZBOhEC/EfvQkW/HITewLyKHe7ayIv
	UK02VzBq22Jh7HPcpXdkk51PfQTC0oij/Qk2A
X-Google-Smtp-Source: AGHT+IGjmOUF0dmAFvQ+spqIORx1VvFbP7DOU+11FOPHLYxp+IkPWpvwS4gEQHgdr928IyJxvQcPXfqsqgvUnrfIthM=
X-Received: by 2002:a17:906:1da9:b0:aa6:a33c:70a7 with SMTP id
 a640c23a62f3a-aa6c1d02831mr275658766b.49.1733996097955; Thu, 12 Dec 2024
 01:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com> <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
In-Reply-To: <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:34:47 +0100
Message-ID: <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 10:14=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> it is now, sorry.

Yeah, this looks very similar and it should fix the bug as well. In
fact the fix part looks exactly the same, I just also changed the
slab/stack allocation while you changed the atomic/refcount. But these
are unrelated, IIUC. I actually planned to split it into two patches
but David told me it's not necessary and I should send it as it is.

Just nitpicking about your patch, the subject says simplify while I
don't really see any simplification.
Also it does not mention the UAF bug leading to crashes it fixes,
missing the Fixes: and CC: stable tags.

What do we do now?

--nX
