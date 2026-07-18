Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556653168E1;
	Sat, 18 Jul 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356058; cv=none; b=ISPIHAWIq+iUvqpIwoY0qHAH5zroTNjlJgW+TvfXr8rjY81Lz57kO3xUT8NHZVER614O8Ys1YAn1NuGH/6+0RO3bgj5c055av4+ooQ0OEGeibmCcbfpFZ6SByLFjT1TRQDe+66beemYzldfjZljzsM2GrUJdUrf1NsbcbWs2ZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356058; c=relaxed/simple;
	bh=aRpmz/vYjTjfw+3XOhLPOTwkQ6I1KuF7Bag8+UUjY0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnugaA2NVotgquAIYU7PGCCI/TSqcLqM/Bce4nmFjbhm0QyYVoY9I1sAMAGNPGUxHq6etdN3jxV5Z0zpztbOVCewUrLGf6lYlSBmuM1Ac0cgFWNB7pEM53Ab5WCcq4H2jebT7z4316u+93tUCPJWaKlwE2R5Oo3i9H39nQLpGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsektBIV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsektBIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A31F00A3A;
	Sat, 18 Jul 2026 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784356057;
	bh=ZW7cLuEz4T+B6zFlZUbyfOaD7LQRr02kMLHIocoLBzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsektBIVYZD39rpHg2e/aqPX8Kk/BsIfRswj/S6Oq0P768K1oHqxJPqbS2I9YT3ET
	 APlh+Oi75wCeWVbERY57JmeDwlYPezoXTuBxZKWrTWHnKTptkRvtj6hefRJDXU561r
	 cvv8dcWTyz2SPRcV+7XH64mkLUx39c2Bjzt1aYVHOzmisfLOuD0Qo6mZJES7AE8+WJ
	 c5icvgeQlfU2o9Reeoe85EERft5w/3TQbAzmEmHvnP3+5OGirhlvZ6doqlSKjJbUO4
	 MuYiPY0gzTuqkZ/8172qX69rF3WnFijuaOszxUVWCKCubyNBTgNmd2xYQpjXTP9xCG
	 tFoW29cu50wDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/3] af_unix: Clean up unix_schedule_gc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <548b1b624b13fc2582b1236a2c656e4261eb2525.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
 <548b1b624b13fc2582b1236a2c656e4261eb2525.1784268931.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 06:27:36 +0000
Message-Id: <20260718062736.C97A31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional garbage collector scheduling in `do_exit()` causes s=
evere lock contention and system-wide DoS when a live AF_UNIX cycle exists.
--

--- Patch [3]: [PATCH net-next v2 3/3] af_unix: Clean up unix_schedule_gc()=
 ---
commit 649d449e71c2d27619a029df46ed559c6fa2ae0c
Author: Nam Cao <namcao@linutronix.de>

af_unix: Clean up unix_schedule_gc()

This patch simplifies unix_schedule_gc() by removing its parameter,
as it was only called with NULL. The user struct parameter and the
logic depending on it are removed.

[ ... ]

> diff --git a/kernel/exit.c b/kernel/exit.c
> index b507b2a24693a..f3bee7cc637d0 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -998,7 +998,7 @@ void __noreturn do_exit(long code)
>  	exit_sem(tsk);
>  	exit_shm(tsk);
>  	exit_files(tsk);
> -	unix_schedule_gc(NULL); /* Must be after exit_files() */
> +	unix_schedule_gc(); /* Must be after exit_files() */

[Severity: High]
Does this call trigger the garbage collector for every exiting task in the
system?

If an unprivileged user creates a live AF_UNIX cyclic reference and leaves
them open, while queueing a large number of normal inflight sockets up to
RLIMIT_NOFILE, the live cycle causes unix_graph_state to persistently be
UNIX_GRAPH_CYCLIC.

Every task exit would then constantly queue unix_gc_work, which executes
unix_walk_scc_fast() under the unix_gc_lock spinlock, iterating over all
inflight sockets:

net/unix/garbage.c:unix_walk_scc_fast() {
    ...
    while (!list_empty(&unix_unvisited_vertices)) {
    ...
}

Could this O(N) loop iterating over all inflight sockets while holding the
unix_gc_lock cause severe lock contention and a system-wide performance
degradation for any AF_UNIX operations like sendmsg and recvmsg that block
on this lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784268931.gi=
t.namcao@linutronix.de?part=3D3
