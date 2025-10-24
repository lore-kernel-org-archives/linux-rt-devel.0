Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FF186E40
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327053; cv=none; b=Nbr+uj49gxKl+X/65UFXZExsY/yB87zBrah9MmZcRedG7Mzp+1cFbCT5exO4ddjY9aJdjk/Fzw2eStBvXCMUmUnYeVyfAblc5eWkHX9Bg24qzlevrIh4P/9IaQxFc4m0CGr00L+FBmruSfTHpPJLmD7uCEVnCGVQy0nzNjgkGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327053; c=relaxed/simple;
	bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw+IrVu8h+oxi6xashd15mt2tpWaxXjx3B1Ub40o15U7vf2lQF/GRVKvmkigE7S0uVZMw8k9c8r5eYfeGNWwsMuk5B/8gCvinG3lwZbJ5qp8gAVp/Sc2dq7QpWdqa6vErbhhHhTE95MPGMe7e+pnze03j96Ldb7tUDWW7cccgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsb4N0hY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsb4N0hY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2947d345949so18942265ad.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761327051; x=1761931851; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=fsb4N0hYXV09aeVUKHLW94Z9J2e2mM5y8WLGrpc7y3o3WB+hl23kSxFE8gWL6F8cDz
         cImT4eaCkxqzPzPACpk7e3Cwet4dc12HE8NXmAWxF9f/wgAvt+hFjriMHkm6zRCnfBqe
         yUFiXkgnngUzqBUaKlK4VJqRulrfKlfybjz/0EvMGmvos/NsRHGJ3JBCKbTI5NpOpYUV
         1qmBuySGiqq7xhOJUFfDr/IrfDjluFip9imecBstMY/TS/1DjKgUnWosSyS+PPGrn8CM
         IaSwzRi7Q9yNZNTUw2ThWlufQMy5FUI4k4p5g69OqBqmxtcg4zOOxrKhhLdnGLDaqAkM
         8/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327051; x=1761931851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=eB5H9RHuSOYZ424jArBV6IRPY3cjOF/4INZSekzCtbGeOdb/hcNvymL88tqerOWQZF
         96VYgY64eIxXFxSSNhhaFuNMJH4B2aLc192gXRF2pRM+W1pRY1JWz0QPS3NBW5hRZxRi
         mpAlKkatEqfltxwpOS/GB5EWtNDsTuRWauE/aaPsg5PIXT8f0lGy/8NUSMTzHJUPllfa
         Nrbs9aO2BHdrQolK4xv6sVym1MDkg4Ze5DGJ9r16sTJj3GPfsQeK4kvzTrlib42z4Lm5
         M2/zSxjr2wwBcNFbl5om5azM8AGQZa+84dUOhLnitpY/65UHWR7TR9CTAtrvgBTgx/On
         YA8w==
X-Forwarded-Encrypted: i=1; AJvYcCVbtmW58NqYnAkLyO6iu52ztXqwI1Yu8/gbvCw2bOAJAV5Cq+DjifPyCIFIsNlosENDE9ynpjnzERt5acsLkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8hunSUz8iDebg+aZgTcHaHqLLJGqPfm62vUlkCPkz9HDPtR8w
	wcm+o90pi/JQ03Z07DLk8RPbTffvcVERb4MH1xrvOnoqaFxXshfvmC9coE/a7zWfEdXEqY5CwcE
	Q5CHWtmpOB1mxz+aEvojSy7ADFJBpkT8=
X-Gm-Gg: ASbGnctMqcgAMXLQgz1G3yZVkXz7VHObkpGugHKuFcOSi7NsLPBUGr4MJq5oFpbRmyZ
	Wz+K3INPnBLbW/xpd7LC6JO4gZWg+JmWOMnXxBpkSORy4bN/xn2q9QxvkzL/G4x9LujjmqpdxRM
	FqEwY0inJb0kRw9lPFZrTc4DSARGQGsEfAC7yBFZJP7RaP+ueeCB932H3uRXvB3yyWn87PQ5Xxx
	8EaIHLqci0Xqc1YDk9TOu3gEzDwBr0F/Wz3vfWdHLrU42bdu3oopwYFtfmEmQ==
X-Google-Smtp-Source: AGHT+IHQhnjzmGIGhBDoQ4ngdvtx/yYjY0WDUYmMTlcSQSZ0eDN1W/dXc1+Jq8Cx2TnQgYBz6MVBdKFjMRDBtJx3n+Q=
X-Received: by 2002:a17:902:cec7:b0:290:afe9:76ef with SMTP id
 d9443c01a7336-290caf8505bmr377100585ad.40.1761327051116; Fri, 24 Oct 2025
 10:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
 <20251010071555.u4ubYPid@linutronix.de> <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
 <20251024131719.tJRyYGcD@linutronix.de>
In-Reply-To: <20251024131719.tJRyYGcD@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 25 Oct 2025 01:30:40 +0800
X-Gm-Features: AS18NWDuFjVwPVmnhn7ThOaKPPOq5x-YUVnqIn4rpEZv7zoFKB8wtJ_ayD8162s
Message-ID: <CAH6oFvJ-24v2X_NrxXjYvODp_9+ZRXQQFGzWq0NcNn3Yb4-Gqw@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 03:17:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-11 01:18:05 [+0800], Guangbo Cui wrote:
> > I will drop the lock in aer_inject_exit, and update commit msg.
>
> Was here a follow-up?

My apologies - I=E2=80=99ve been quite busy recently and it slipped my mind=
.
I will post a new version of the patch this weekend.

Best regards,
Guangbo
