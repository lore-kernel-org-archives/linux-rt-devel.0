Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65896211A11
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541911; cv=none; b=X0lzBM94d5NXwXrh1V21nNpyJVM7OYZ807IiBJewaE7ao76wVMVgMvo/GZbOEoOO6NtmCQ7InluVIprqU8tBWAiSZEV0ftxR7nQhJdqSug6CvDT3Nszah4rJoTkYSnr1invKuqFbin0GJPseMvnbHrKfh7cwKRP3CnRjrAVA50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541911; c=relaxed/simple;
	bh=KOkgUuihs4pXMo5Uy+m5Qp4FIS7N4JkZmvcjw7qGj04=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qd+7qi1LTArnnY7OT27xw2jtEjW7xlWlg14KyXgMDM/F8wQdTA4kFjr/AcQpWmoNMOHPtI5/MDLsiVHaOeKIf9zCJ/o6ufRQAmE3LJhuSv3Y4FYgVfXljjsKJOIp06+8S66DBT3KohdmtG/p1ez9bY+VP0RUBAJv+Pxeh7ybor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/i7RP/V; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/i7RP/V"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb73621fcso516550266b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755541907; x=1756146707; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pjGB0SFkv4MBKb4iw4skaOsLgOvxbygJAcvKTc98B44=;
        b=k/i7RP/V6UiPINkpS1IB2zFSxVfemcJ2oVmrLrd22tHBdIZodihkcqibO9lHbpBS92
         +mzi2Ra5imxv8cfBdNZN+dKk+QE8ICBby7g9TAm9/neP213Ua4OsVJR+9Gk+J2R2vSqF
         wkR827tn/G+L6MUVvg2V2QexmK5j468XFjPKP18hM6vfbFgDPI85Da89zKadM1la5N0G
         8EkfFkTO3FfEuT2ViW+vgFPKWcvi/gtR+u+AWc3mFF3VDfBR4TXtE6c4tN7qp5Kz5Yer
         RQc5xfNO6H0DIOci0vLdH8MICmfgDy1HEchwR0og/QHwiZItbHWIrXWPoanwMLpOcCXU
         6PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541907; x=1756146707;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjGB0SFkv4MBKb4iw4skaOsLgOvxbygJAcvKTc98B44=;
        b=duOaUhSFCYr1qfoNTPsm6k3e1OoRiWfifaLGklwb4JiKYuMkrmk4MOm6R02ZaxvxQq
         erXa0dLmqXky/S98jb7Rar1PMducoNZd1HvXUu2EoVQ7Q1wOOYOpqP9lWpIkXGg0VzC+
         VU453fZrzFKKs6Rp9NavcjFe8AkkzPLBfaHny+4zQ/si6H7UetSQ9MBEnoiwrv4qAXfB
         45Qvsgn8k7jcEk/Ot+JPPSFmSYn5dXgIwSQqs45zSgkvFfFofzc1mn8ZmXcAVUXvH1rD
         +/MScDkqN9OVRaVKa8sbmYrg5NjvSJc4sJjlZDykeTxmNd6u46HSSVn9qaXDSvceRUUL
         bCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zlA1PlB/K029M6cc2L55MJW+5jWbrjLlJ3slXMHqQWSZgusEKSltw0VgCMk4h1Nef7lZAGQylPyN9BaSTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5Ctm/QmlN4psw/jUTzyLfcYCm+PXNGHGDj2YxooLBLtX/Mpam
	Xqyd2/yOKUKJBrkMzcsFn0y5BPwKi8Q0l2gFrH7a6oUrsqojgDEoqKjDob4rFbmU+ZXMBzlVmkr
	vc0mmebLH/zR78p0ggXdw53tJXq78R/wsT7DBk8fwmg==
X-Gm-Gg: ASbGnctZtLy5fU0t0/hjCop1aq9U5Vzqo99Mb3vbR5e01A77CxZLUSYG0AdkQB0yqoA
	UqQlmwxfLEspYx1wvAkkVJOgRBtOUQ513VbUh8mLGmaHl6ZdIdAXH/rrW8L/GMqVaE14On6xe0n
	sFo64Xk9iUt3k4GxJpJES7LfbM9bdQNIaYlhWPlAnGGWCvU/Njz0MIbT5fbm+vPpQKJ0c4zkxHR
	7B9uuJiEFMx2ofDuKTUWQMj2l+52A9ep3I=
X-Google-Smtp-Source: AGHT+IGqSl8L73R4Vo9ejBt0vBasMnPfvGJ08z8fntAtUKzrrLi0v8pEEOjQaG+5pgsw8Bcn1FtRYar+LPvGWV1YFDw=
X-Received: by 2002:a17:907:986:b0:af9:9d7b:6f44 with SMTP id
 a640c23a62f3a-afdd9a8b1a5mr35098866b.19.1755541907580; Mon, 18 Aug 2025
 11:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 Aug 2025 20:31:36 +0200
X-Gm-Features: Ac12FXzUhIUFY2dVNx6YHCxJPdcfbv7G4qSvst6qOsN6AJMqiBVTN1nrINRXEsA
Message-ID: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
Subject: Call for Speakers: Join us at the Scheduler and Real-Time
 Microconference at LPC2025!
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Phil Auld <pauld@redhat.com>, dhaval@gianis.ca, Aaron Lu <ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

We're pleased to announce that the Call for Topics for the upcoming
Scheduler and Real-Time Microconference at Linux Plumbers 2025, is
open!

    https://lpc.events/event/19/sessions/218/

This event is designed to gather kernel developers and engineers to
share knowledge on scheduler and/or real time issues in Linux and
connect with peers. This year, we are joining the tightly linked
Real-Time and scheduler topics in one same microconference.

We're particularly interested in talks that:

    - Spark Discussion: The goal is to discuss open problems,
preferably with patch sets already on the mailing list.

    - Are Concise: Presentations are meant to be limited to 2 or 3
slides intended to seed a discussion and debate.

Some possible topics for discussions:

    - Improve responsiveness of fair tasks
    - Improve PREEMPT_RT
    - Improve Locking and priority inversion
    - Impact of new topology, including hybrid or heterogeneous system
    - Improvements on SCHED_DEADLINE and DL server
    - Tooling for debugging low latency analysis

It is also perfectly fine if you have a new topic that is not on the
list above. People are encouraged to submit any topic related to
real-time and/or scheduling.

Ready to submit? Please fill out the submission form by

    Sept 30th 2025

at this link:

    https://lpc.events/event/19/abstracts/

and select

    "Scheduler and Real-Time MC" as the track.

We can't wait to see your proposal and build a fantastic lineup together.

If you have any questions, don't hesitate to reach out.

Best regards,

The Scheduler and Real-Time Microconference Team
- Dhaval Giani <dhaval.giani@gmail.com>
- Juri Lelli <juri.lelli@redhat.com>
- Phil Auld <pauld@redhat.com>
- Steven Rostedt <rostedt@goodmis.org>
- Vincent Guittot <vincent.guittot@linaro.org>
