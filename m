Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66C295511
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Oct 2025 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895074; cv=none; b=RNsxJygTISPTYDE4561D07SLpQFODU4rpYPBPhlTtGtWiX2Qhq0j3vXzeunC6UvpwnHkY5jhLWXrsk12IEFwPziRAU3QuHFyrohOM74UP97HzuQ9GTMBg46p1MJkCGoYu5AhTT/wIje3BeZAqS6/V2TnK7yIe5RNwGHZ8oNwBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895074; c=relaxed/simple;
	bh=QwxYTjM/Hs56IWPzeA4KrNyLGwDxDEJRONFXjgNhoyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye+UVuOKI6UqxGTpq6ky2yCogJy9HcfySCv/y8FS/+p5L1sIlOaac4ItPhtKPZ2hPOXqYgJOyWLTtXnYY93413PtAyTy68LClNASHEsQntymHq4JEcV9SKfmQ99hFZxFFeE7wPukKUJ1lG5lkUbrfwiEdel2EtL9brF56vSxc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc+XvyzM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc+XvyzM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso6063946a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Oct 2025 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895073; x=1760499873; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=Mc+XvyzMP3p3ymvnuyt/qq/6mR0oFWFIW+l+aJ5mcquFM4fSOhjzSSbKVUnxVuGGm9
         MPn1K8NkyUEG6qOdjWhQo5ffHXHdbLzj8DELCH7JPiF2jDu4ERUoNKqpvPZ9V/P1bNP9
         FZ7nEtx4JuRmrx2vjy98Z+37AklJRyzZoSdnQ+Ya4sA1ICqZz/WYQrsSHRs7CzwZzf3M
         gIk5zwPVAGbK9XaoOPklVoZMIUDC6bBIO0D+R3KPJ/7iHX/dRCiouGsSCf5jrnM5wt9V
         fEJfqgUrAjLqTsVIv4YbLeOlFlhIod8qzbc10al1MMhhXhp/ardkUlbdFK+gCdB/IqsR
         BJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895073; x=1760499873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I759iT4j8SDZVd7J4MI01EBF6i0nlohVy9HPt2MhIoM=;
        b=jZfkRiHsxB3u0IrU138kElD9mFyflwUpk0pzt2pefqey3M9NxOVVafdrNr9HILBVPF
         cDx+YlnksJshwkQOJeY3BVUTLBKWT9ouuMWvxnMeX7cdVtymBbhJYqMABUPufMkQhU3n
         sBJSJMImmVQbsx9O93hzYmcVgbmkHCQGNGCoDYqcP8iGxYqgqlPRffOplT7MPQ/v5eoB
         /oPVYjFS5KPs7BgFWwB2NTKoOt1QzRO++zXFivql8TZRlHiUSMt3UhlYao63ruUlcN/5
         Nj2tcpCbQLpJcCRCRnm0EI5CoiAqMeiw9y1E2wUMijgonw8OvhESwhkBun0Hvu57keYu
         EZng==
X-Forwarded-Encrypted: i=1; AJvYcCX+eQKLhuWCyM1HyrLJ3IXwaNrnIK4Qx1ECgWGQBId8dUqi9ICGonLJ1yheffqD6rDa/SojF5ZS30OhN4Vybw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy9zsk15CxvM0/yi1sIJ1NJ9JylUQCksLi6v5rqSWd5mrx+Oxu
	ksXv67fE6UdgUwlZhlQMAw9bqCyxlkxh3CqYIUpQKCzOSD8PoEv3kP0Y
X-Gm-Gg: ASbGncvzWMMXyFm2DCy9MTr2th1kBoYKdn5iuhnsjuRFdBkBXVy4RMA52lXYhAsqjSq
	JyKOFiaRPv2OhCrO0bL9586QvRHJly9S/KajLkDzCjnA6iP38K01vtcvPL/37/0B4ppzUtYWAQP
	V5hgDQ95lSXyE8v5tShGYDGBT3+4NRk4oTY/zB6nZ5TMozXwzvq97kBxpn7X2OyQJQ24hrBesc+
	7vw73FOSSxkeIQmwO8K7xKcoNj5Hv8gcb4Cg82ELOiDhsmEMdKod8xjpU/+RaESlp+JpBWZjdma
	XxEeQaJo4ZMHpCBmhH47w0A+vjlN1PdjUETB8A3ZNPURDOdjrE1sBkCrzjouEtRLj5GGbfF+499
	ZO8cHGHGzlJF6HacLYNtVTuIyRbSUxza5Op0E3nhvc/U9a4hj2uW+xsJBKhdIrDO6bvPav2ez
X-Google-Smtp-Source: AGHT+IFupCckjpcLo39oZCGHlaErTF4u7UG/c6eq09cdH5+LiWmXwTrf7Bt/BU9N70lcGOmKNtu34g==
X-Received: by 2002:a17:902:ef4d:b0:27e:c18a:dbb1 with SMTP id d9443c01a7336-29027373cb1mr26274475ad.16.1759895072595;
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.198.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108c5sm182331855ad.16.2025.10.07.20.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:44:32 -0700 (PDT)
Date: Wed, 8 Oct 2025 03:44:24 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
Message-ID: <aOXeGFJLuMsPqAjw@2a2a0ba7cec8>
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
 <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
 <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
 <20251007161229.7IT0x9Me@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161229.7IT0x9Me@linutronix.de>

On Tue, Oct 07, 2025 at 06:12:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-08 00:10:45 [+0800], guangbo cui wrote:
> > As mentioned above, the list is usually short in typical use cases,
> > since error injection is mainly used for debugging or development
> > purposes. Perhaps we can also get some advice from the PCI folks.
> 
> Is this something that is used in "production" or more debugging/
> development?

It's mainly for debugging/development. Debugging AER code is difficult
cause it's hard to trigger real hardware errors.

Best regards,
Guangbo
