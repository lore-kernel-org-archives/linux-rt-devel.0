Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4581FC0ED
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597794; cv=none; b=mMW5bwRHvPQ1FhniDBCVeIKG2Ot2yS02E99+JYllVD8q2gak5w0hh1HKN7myixHFeJPI44Y1Q1NJ612Wwy3mFyTOhub+gx266qzjWEb5JjkPK2umY8syxXIJcUR5t3uj0cC502wJUqD42Ug7HV+lfNDiMRN/xpmIgPC9XSlyMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597794; c=relaxed/simple;
	bh=OZLBdP80AuAPBpQatgV4tnOFj5nsWaDVvWpCLDIyI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDLJMDR8X0x2vtuq58WDctzXzeFuKsAJlNIGAsz5Gbjr257jtgJgGhtGnoznNeEEWP8/Hdgp9EWbx3Bhd9LikcYDo6qjHdCkrZAHHgUYqoFdehmAGsgdXCDvJgXatqtLDqBSjdqHbH9ZHwA6YiecwPslBJXBUlelTyfvlyTXZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UfXIGoPj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UfXIGoPj"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3b336e936so1114402566b.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752597791; x=1753202591; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=UfXIGoPjuI8jYzgwBPFKMkLHaVR8eSRo40lBeOI0SSFAYAykI09xx5PHYrdpwh2Ity
         rdFZ8b6Ubz9GisZ5SIVcsG0hHT11vO9LbmTK7oEYUB65Vfb4xPYFYslYOhUTlWj4ay1b
         qFXF5fLL+KdfGljkAUXHe6HGeBDGqcV1KxQ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597791; x=1753202591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=X/rQse+hxkUwGnx7yGgrpwqbcPYFrh6Hrb34Vq5abDXY1SKKhvhbcpR0Md+5TskcDL
         OjDLris8BJyIR/ffcS4yTX7O0c6NUNKQKWH0sgZYwXcCMR+IWJGmtrHq4SrsSBEH6K2v
         LowuaUUlMYVmphNBDiKcmJ+EgDjEMJe4eiTE94sf36YIOCTMIu0Mc05p1zCxtjg19tBg
         UduNQ7C46jAGiVUZkGHFfd60moVI4UerwGDza0boq3nhk4OqXy3H1CFWwgQ17M9MI+yH
         Otv71r6TyQi2QjrsXKpPaTK+4kqjl9VN2Qv6qnqwzbr4IBBPVgR8BNbPpu2MFYxAKWfW
         b/2w==
X-Forwarded-Encrypted: i=1; AJvYcCUjdoePA0iw10B1BEQlVQIN0h0np9QwSm+fwRRixP0QsxIwbBIRUtvaM5tm6Xy+HCpiA3ljUH33y2l2K1EzsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAtfk0qIhyzuFBd6CGA2v3HlWyuunNjkrmK40qzLYaUSoWaOHl
	GmiUjFx7pom6mZxd5VIRMlcOmDq4TAvaGMCdG013Y93Iv2t6Pxyb+4Cqy9sNEDtxx1wmW56pspP
	lgIu6zdM=
X-Gm-Gg: ASbGncswW3F0qKigreUt/MY/dsCT9Dqfx7kMdvqujl4X+firgc87LVsfZwf+T6bBJkJ
	hktW/wEpUtrMCcgL0T0NIJJEkMuvJSYmBUAcan5zTv1Gp865nduHcGROI/FXZOyqQB/yAnqs6jg
	ZPXNX/5aiRHvGD/EqHyEY+VVb0CIL7z8T05rs3p6/UNYon1ryHoNw3eJbDa0SkKowRdAe6+ncPJ
	sNdJL6MSDvCTuNws/HXpAmnUGeDBfymtxPwRt8fzSc6GcCP4MckWIv2Ver1JFIvDLlgxddoKxgU
	IOeiVZ0vP/DU5fsqgK2dPs//1yH26QZLcdYELQNEePlxWovCbLGY88/cB5smB6pajQsPUpojU/D
	ZHWxb54YV297y4NuIRPMrrBNbyEUeRfE/J+Nw2RlyMRjbhBjPFAPvxZwXwfL3JSW5+ORcvS5Y
X-Google-Smtp-Source: AGHT+IGR9aP+Net23VhtZVYRxXiGT9VoVreDdXPQKMxXrnLtk2rwQsxq/VQvrCS6pUd/NcYetpc1ZA==
X-Received: by 2002:a17:907:3d11:b0:ae6:e0b1:9633 with SMTP id a640c23a62f3a-ae9c9b10deemr16336266b.33.1752597790649;
        Tue, 15 Jul 2025 09:43:10 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bb2sm1022926866b.113.2025.07.15.09.43.09
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso10384941a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiU5qgM9EKZE2Vh15SyxjMehB5IIBZt7O85GolzFiWi9oZWKkLKzSPiuuLbbJLvCxWS4WqgzX2N+o8Mpl2XA==@lists.linux.dev
X-Received: by 2002:a05:6402:2686:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-61281f226d2mr26921a12.3.1752597788853; Tue, 15 Jul 2025
 09:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1752581388.git.namcao@linutronix.de> <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Jul 2025 09:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
X-Gm-Features: Ac12FXwEFq81tRpxQQo-YtMJ6UxIp_wzb2appHmE6OGEEPULt8cuT-X-Zaqr3nQ
Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
>
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)

Yeah, this is more like the kind of diffstat I like to see for
eventpoll. Plus it makes things fundamentally simpler.

It might be worth looking at ep_poll_callback() - the only case that
had read_lock_irqsave() - and seeing if perhaps some of the tests
inside the lock might be done optimistically, or delayed to after the
lock.

For example, the whole wakeup sequence looks like it should be done
*after* the ep->lock has been released, because it uses its own lock
(ie the

                if (sync)
                        wake_up_sync(&ep->wq);
                else
                        wake_up(&ep->wq);

thing uses the wq lock, and there is nothing that ep->lock protects
there as far as I can tell.

So I think this has some potential for _simple_ optimizations, but I'm
not sure how worth it it is.

Thanks,
          Linus
