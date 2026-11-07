Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071600;
	b=vySn2YIjhUudzysk7044oniiSj7aG84ZJjrSytnah0QNp3LsH2PY6Bl5f/SCTF3XFqp4
	 RnkMlhWCwV8cMowVDoabdvZn7C6Zsi5z2tg53ZhITbqECHTAloAFEuGuqRGa0zDqKPJH7
	 FBRMA7dW/4buJ+dspsEFEtrB5hsin7xPQu6BIISRbA8buN8o6GI1o2fSi7QcbHJ0wMgh8
	 ZXfju5pCwepIETOON3LXmQnk0wB2zcrnVICC0UuXweMQ1bpVXpGXPwKAMB5sxVPAE+tOM
	 XsExK5rvXULgcZB+dPEI0CEDPDHzCyfHfiuBao3JcT7ssSWwKh6IaBzDIRzQwZgqz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eWNSEsSwVt5YTKCfi1st6fCrwdvuoSW1sFyhHtvjjtQ=;
	b=o19cpSSCGz5zRJSE1VwLyGT84/cVw13cjcbztWkUlkNsufAwJOw8tYZZUKCjvLMLAxsT
	 0drp+qwHRUQ+SWc8/NCABdS9vWSlwap9cvtjaiHj4d538NyaoRBVh82tvR5c9M4Cc2I9Y
	 gw1kz8yG/SzWN5FIehlbW2MqTaN/Fny2Ya3XG2dR9d4I8ELCKSE9jdsGguIYZoWymZzBp
	 FgFKH0DHrAIqyLXe6zKHxN1pBciULKH0Q2EMgdmvL2tw8mmNo8g2S/ZpDiUC94GQKD+ez
	 3XGoTrW3bEf1lJOLgYLHVHI3mXYZ3Yes+m/0WRTlvvck8f5gfO90wxi+p75k1+l+diA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5FiEOqX;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C0606D83A
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 17:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6C0606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5FiEOqX
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so18367565e9.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071598; x=1794676398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWNSEsSwVt5YTKCfi1st6fCrwdvuoSW1sFyhHtvjjtQ=;
        b=Q5FiEOqX1mWAkQKAZBEM16L4lWOXU056P2ScNzV22L0ZA70EMatIw2Esxoa0tEkrpD
         m//X/SKcTmwD2kpwgbpVSF5WECBJjgn5lznYS/8wuvKX9WFztQqQaGJZNrKsjqMRL4GV
         u7+wzWDWRFR9EXUJAo9rgN2Of1jjWSnVzDhKsuinz8vqdoejvjZvtyPMbUO1c0fGGNju
         /un/4dJL/2hiZSCqcHVTt/iAVW0PCz1sc9YR09Yg47VyqvBaU5ivGjygms7REd74lrGk
         uepKYszFEM6D5zP/DgBS97/oMCgX74W69PA0oj6//+aRFw1ojPofJz0xI0DwA49Cn7Tz
         MS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071598; x=1794676398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eWNSEsSwVt5YTKCfi1st6fCrwdvuoSW1sFyhHtvjjtQ=;
        b=PZo02Cgwpf6qy8zgRfqXlKefD9UFEJnPRSaJvQAIH/pPVfbU8qS2lxtrZYVc+8vs8z
         aPXvIDnIQA7/yYtI02OYIYoFkMNQn/O96mMRZXImHuwdOb/ujO2FDLj3flfY5+3mw4b1
         uFNm84ZN2QVKVGpSp+Ll0CpXEOCT6SGJqz/jcp+kruZcF1xyNg6OMKVgMHjq0DUXleb8
         3q+Dd5CZXdW0uIq0T9cWWW+K2ogaRGeE36QrtocToqtQ8CMClo4sADb5P0AcNPDWQqpT
         WKJwSxrrGYXJmsTQwc6SXS//ALqCSGih42LypSf8Dcnmn+QqwFElEI7FioO0Oywg5PjV
         6Qmw==
X-Forwarded-Encrypted: i=1; AKwUvBxOJ2yWsOhquMwwq2wj2tmbwsf6su0p+P+mHs9gXqfBDrbAwFWa8cxA5bawm1WpJWayV8LN+yOwmyo7yyEHMQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9UprCG7oHfq/REGDnxK/m/WLkq4RVQOTNJRVr5/F6/vJDtCg1
	vpzg1nxpCIDXvcpi9hEZWfPVGRWoHkuWt3Io1unejEC1nMbpanRgLuJ7
X-Gm-Gg: AYBFou2jz25YwdWeontAg8JP6+MGysKWhuVFUoKzDJ91xvRMUvi7To4mPZNtOeYnnqx
	/encQn0AQa2PgWBk8z04u3F0fEZ0BqiA6prcXSTcUvzgKqo/HbcoAJ+mvNU2Cx6J+xwAndWsZ5I
	YO8KT0dovoVHNzdMk2q1Ya5PPh6By8hKWgLxS6ZNOWE5vP6LKGQsCRK91eHuxNrOxQILX+GtpnJ
	uS67p2TpUPeMIAzwf9sibwKl8EZm3EoWTea1Rm4VBuBSmXE8k20y4ZJcaEe9nBE/PGLHI+xLdAh
	Wt1df0HA1ocJwRGPvYTy/dDGASTq+QOFhN0WiKLqcBEwbeC3KsjK+20bYPr2f9HLiFTZ6qq1x7l
	070L5dbt6iTFT6EjA2sj8FWZ7Te7QU27C9vXl0IevYAPoIz0lpnsx0FypZDsbhr1lR/BmProfhu
	VcoI+OisNAcUKDJsOznl6x63snQc1XbTSocHCgw2tOadOPjj3xoeQm64k5RcGsOW6SzRHBc6U/r
	u+OZaiUHl8kK0O0dzc9r4pGFFmBRdykaA6JBb3LtwDEPW5aLCIa5gtGA8Cs+98sSrYxBM5Qquz4
	QM+aZc96tBPBS5NivZbR0XCaFkmKA+glDXTtwyw33jEqI1YASm31PQNzZ4DGwMqirb5GZlSPeIU
	gToP/l6wRM66p5XXv/kwPpHPhjGRiWP+1mYMTxEln+uv3ob7MWF9bmv3MKLUoqOXWssQ0AJ7a/s
	OJbZ4506c8G6B82zWfed308IMSq+DqCPI=
X-Received: by 2002:a05:600c:4f4a:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4b6e017248dmr113719735e9.30.1794071597881;
        Sat, 07 Nov 2026 09:13:17 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:17 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/9] docs/rv: Document the IRQ monitors
Date: Sat,  7 Nov 2026 18:12:48 +0100
Message-Id: <20261107171252.25090-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the irqstate and irqexit models, including their text
schematics, synchronization rules, PREEMPT_RT behavior, bare-tracepoint
boundaries, per-CPU vs per-task automaton separation, tracefs interface,
and coverage limits.

irqstate observes hardirq contexts whose boundaries pass through
irq_enter() or irq_enter_rcu() and irq_exit() or irq_exit_rcu(). Direct
__irq_enter() and __irq_exit() users, raw-only paths, and
architecture-specific intervals before generic entry and after generic
exit remain outside its coverage.

Clarify that irqexit monitors preempt_schedule_irq() as a per-task
automaton rather than treating it as the complete interrupt-return path.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/trace/rv/index.rst       |   1 +
 Documentation/trace/rv/monitor_irq.rst | 350 +++++++++++++++++++++++++
 2 files changed, 351 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_irq.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 29769f06bb0f0..8dd4041e1a0eb 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -15,6 +15,7 @@ Runtime Verification
    monitor_wip.rst
    monitor_wwnr.rst
    monitor_sched.rst
+   monitor_irq.rst
    monitor_rtapp.rst
    monitor_stall.rst
    monitor_deadline.rst
diff --git a/Documentation/trace/rv/monitor_irq.rst b/Documentation/trace/rv/monitor_irq.rst
new file mode 100644
index 0000000000000..3e4aa819fcbbc
--- /dev/null
+++ b/Documentation/trace/rv/monitor_irq.rst
@@ -0,0 +1,350 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+IRQ monitors
+============
+
+- Name: irq
+- Type: container for IRQ context monitors
+- Author: Karl Mehltretter <kmehltretter@gmail.com>
+
+Description
+-----------
+
+The ``irq`` container groups monitors which compare interrupt-related
+events with the execution context recorded by the kernel.  The monitors are
+architecture independent: they consume generic tracepoints and do not require
+an architecture assembly hook.
+
+The first monitor deliberately observes only safe, instrumentable events.  It
+does not cover the interval between physical interrupt entry and establishment
+of generic hardirq state.  The boundary hooks are bare tracepoints declared
+with ``DECLARE_TRACE()`` rather than user-space tracefs events.
+
+The two specifications use distinct automaton instances because they track
+different objects.  ``irqstate`` is a per-CPU automaton: a hardirq interrupts
+whichever task happens to be running on that CPU, and non-RT softirq
+execution is CPU-local.  ``irqexit`` is a per-task automaton: an invocation
+of ``preempt_schedule_irq()`` belongs to the interrupted task's stack frame,
+multiple tasks may be suspended inside the helper at the same time, and a
+suspended invocation can migrate to another CPU before returning.  The
+container enables and disables both automata together by default while
+keeping per-CPU and per-task state independent.
+
+Monitor irqstate
+----------------
+
+The ``irqstate`` monitor checks the ordering of hardirq contexts whose entry
+and exit pass through ``irq_enter()``/``irq_exit()`` or
+``irq_enter_rcu()``/``irq_exit_rcu()``, and of complete serving-softirq
+contexts. Each boundary must agree with the corresponding preempt-count state:
+
+.. list-table:: Event and required context
+   :header-rows: 1
+
+   * - Kernel event
+     - Model event
+     - Required environment
+   * - ``hardirq_context_entry``
+     - ``hardirq_entry``
+     - ``hardirq > 0``; serving-softirq state selects the source state
+   * - ``hardirq_context_exit``
+     - ``hardirq_exit``
+     - ``hardirq > 0``; serving-softirq state selects the destination state
+   * - ``softirq_context_entry``
+     - ``softirq_entry`` or ``softirq_entry_from_hardirq``
+     - ``hardirq == 0 && serving_softirq == 1``
+   * - ``softirq_context_exit``
+     - ``softirq_exit`` or ``softirq_exit_to_hardirq``
+     - ``hardirq == 0 && serving_softirq == 1``
+   * - ``sched_switch`` from a serving-softirq task (PREEMPT_RT)
+     - ``softirq_suspend``
+     - ``hardirq == 0``
+   * - ``sched_switch`` to a serving-softirq task (PREEMPT_RT)
+     - ``softirq_resume``
+     - ``hardirq == 0``
+
+``serving_softirq`` uses ``in_serving_softirq()``.  It therefore distinguishes
+a serving-softirq interval from a task which merely disabled bottom halves.
+The hardirq condition uses the hardirq component of ``preempt_count``.
+Softirq events also report whether hardirq state was replaced for inline
+processing during interrupt return. The exit event reports whether hardirq
+state will be restored.
+
+On PREEMPT_RT the serving interval includes preparation before
+``handle_softirqs()`` and teardown after it, not just handler execution or
+CPU-time accounting. A worker can enter and leave this context even if its
+pending-work check finds nothing. The RT entry event follows the counter
+update that sets the serving bit, and the exit event precedes the update
+that clears it. Processing inline from ``local_bh_enable()`` has the same
+boundaries; ordinary BH-disable nesting does not emit context events.
+
+RT worker entry acquires any blocking BH lock before the counter update.
+When the entry tracepoint is enabled, the update and event execute together
+with local IRQs disabled, then restore the original IRQ state. No new IRQ
+disable/enable pair is introduced when that tracepoint is disabled. RT
+decrements already execute with IRQs disabled. Non-RT retains its existing
+IRQ-disabled processing-loop boundaries.
+
+The model has six states: ``idle``, ``in_hardirq``, ``in_softirq``,
+``hardirq_from_softirq``, ``softirq_from_hardirq``, and
+``hardirq_from_softirq_from_hardirq``. The initial and accepting state is
+``idle``. The following schematics omit the guards listed above. To keep the
+state names short, ``A > B`` denotes the state reached when context ``B`` is
+entered from context ``A``; it does not imply that both context-count
+components remain set::
+
+              hardirq_exit
+    +----------------------------+
+    |                            v
+  +---------+  hardirq_entry   #=================================#
+  | hardirq | <--------------- H              idle               H <+
+  +---------+                  #=================================#  |
+                                 |                                  |
+                                 | softirq_entry                    | softirq_exit
+                                 | softirq_resume                   | softirq_suspend
+                                 v                                  |
+                               +---------------------------------+  |
+               +-------------> |             softirq             | -+
+               |               +---------------------------------+
+               |                 |
+               | hardirq_exit    | hardirq_entry
+               |                 v
+               |               +---------------------------------+
+               +-------------- |        softirq > hardirq        |
+                               +---------------------------------+
+
+The softirq interval during hardirq return and a hardirq nested within that
+interval form the remaining part of the model::
+
+                   +-----------------------------+
+                   |           hardirq           | <+
+                   +-----------------------------+  |
+                     |                              |
+                     | softirq_entry_from_hardirq   | softirq_exit_to_hardirq
+                     v                              |
+                   +-----------------------------+  |
+    +------------> |      hardirq > softirq      | -+
+    |              +-----------------------------+
+    |                |
+    | hardirq_exit   | hardirq_entry
+    |                v
+    |              +-----------------------------+
+    +------------- | hardirq > softirq > hardirq |
+                   +-----------------------------+
+
+The ``softirq_from_hardirq`` state represents non-RT softirq processing
+during interrupt return. The kernel replaces ``HARDIRQ_OFFSET`` with
+``SOFTIRQ_OFFSET`` while the handlers run, then restores hardirq state before
+completing interrupt exit. The ``hardirq_from_softirq_from_hardirq`` state
+represents a nested hardirq during those handlers.
+
+On PREEMPT_RT, serving-softirq state is task-local and the serving interval is
+preemptible.  A switch away from that task suspends its CPU context
+(``in_softirq -> idle``); a switch back resumes it (``idle -> in_softirq``).
+The adapter reads the outgoing and incoming task's softirq count at
+``sched_switch``.  Interrupts are disabled there, so no hardirq boundary can
+occur between representing the incoming task and the actual context switch.
+A hardirq in a task which preempted a softirq therefore starts in ``idle``.
+
+Hardirq depth greater than one is collapsed into the surrounding hardirq
+state.  The depth comes from the existing hardirq component, so the monitor
+does not maintain a second counter which could wrap independently.
+
+The boundary events run after entry state has been established and before it
+is removed.  A false transition or guard invokes the selected RV reactor and
+emits the monitor's error trace event.
+
+On hardirq exit, ``hardirq_context_exit`` runs near the end of the generic
+exit path, after tick-exit work and before removal of ``HARDIRQ_OFFSET``.
+Hardirq accounting ends earlier, before inline softirq and tick-exit work.
+``irqstate`` returns to the outer model state at this boundary. When the event
+is enabled, the outermost-exit handoff passes pending timer work to ktimerd
+with forced IRQ threading. It also passes pending softirq work to ksoftirqd
+when no enclosing softirq or bottom-half-disabled state suppresses the wake.
+These handoffs catch work raised by tick-exit and event callbacks. The event
+does not represent return from ``irq_exit_rcu()``, the later reschedule check,
+or the architecture return tail.
+
+Hardirq accounting and lockdep hardirq state have separate lifetimes. Lockdep
+can also create a synthetic hardirq interval without changing
+``HARDIRQ_OFFSET``. ``irqstate`` models the preempt-count context and does not
+report those lockdep-only intervals.
+
+Synchronization
+---------------
+
+Enabling a per-CPU monitor does not imply that the CPU is in task context.
+An outer hardirq or softirq entry from a known idle context starts the model
+and consumes the event. An outer exit can instead establish the idle state
+without consuming an unmatched event when monitoring starts in the middle of
+that context. Provenance-marked softirq boundaries do not start monitoring:
+they belong to an enclosing hardirq. If attachment occurs during that
+sequence, its final hardirq exit establishes ``idle``. If monitoring starts
+while a hardirq interrupts an ordinary softirq, the hardirq pair is ignored
+until the enclosing softirq exit establishes the idle state. On PREEMPT_RT, a
+softirq suspension also establishes ``idle``, and a resumption can start
+monitoring directly in ``in_softirq``.
+
+On PREEMPT_RT, probe attachment waits for an RCU grace period before the
+monitor can become enabled. This drains BH preparations which sampled the
+entry tracepoint disabled before attachment. Otherwise an intervening IRQ
+could synchronize the model to idle before a preparation publishes its
+serving bit without an entry event. New preparations see the attached
+entry probe and serialize the bit update with their event.
+
+Monitor irqexit
+---------------
+
+The ``irqexit`` monitor follows each task's invocation of
+``preempt_schedule_irq()``. It consumes ``sched_irq_preempt_entry``,
+``sched_irq_preempt_exit``, and ``sched_switch``. Both boundary events must
+observe zero hardirq count and disabled local interrupts. The owner saved
+in the invocation's stack frame must match the current task at both
+boundaries.
+
+The boundary tracepoints pass preempt-count and interrupt-state snapshots
+taken at the scheduler call site, before tracepoint dispatch can change the
+observed context. Disabled hooks do not take these extra snapshots. The RV
+adapter still evaluates its original live-context guards; the snapshot
+arguments provide an independent check for direct tracepoint probes.
+
+The model has three states: ``idle``, ``rescheduling``, and ``suspended``.
+The initial and accepting state is ``idle``. The schematic omits the guards
+described above::
+
+      switch_in / switch_out   #================#
+    +------------------------- H                H
+    |                          H      idle      H
+    +------------------------> H                H <+
+                               #================#  |
+                                 |                 |
+                                 | resched_entry   | resched_exit
+                                 v                 |
+                               +----------------+  |
+    +------------------------> |  rescheduling  | -+
+    |                          +----------------+
+    |                            |
+    | switch_in                  | switch_out
+    |                            v
+    |                          +----------------+
+    +------------------------- |   suspended    |
+                               +----------------+
+
+The incoming event cannot require its target to be current: ``sched_switch``
+still executes in the outgoing task. Local interrupts remain disabled
+until the incoming task runs.
+
+Instances belong to tasks, not CPUs. Two tasks may have independently
+suspended invocations, and resuming on another CPU must use the same task's
+instance. An interrupt or IRQ-exit schedule in another task cannot return
+on behalf of the suspended owner. Ordinary switches while ``idle`` do not
+change its state.
+
+An entry starts monitoring and consumes the event. If the monitor was
+enabled during an existing invocation, its first valid exit instead
+establishes ``idle`` without consuming an unmatched event. Switches alone
+do not synchronize a task. An exit with an invalid context or owner must
+not be skipped as a synchronization event.
+
+The helper can also run on a kernel exception return. Its events therefore
+do not prove that an invocation followed a physical interrupt, and they do
+not describe architecture register restoration or context tracking after
+the helper returns. The existing helper entry assertions can reject an
+invalid caller before the entry event; such a failure is not a violation
+detected by this monitor.
+
+``irqexit`` does not associate an invocation with a preceding hardirq. It
+cannot observe work between ``hardirq_context_exit`` and the helper entry or
+between the helper exit and return to the interrupted context.
+
+Relationship to sched/sts
+-------------------------
+
+The scheduler ``sts`` monitor models the ordering of IRQ disable/enable,
+scheduler entry/exit, and task switches.  It uses ``irq_handler_entry`` and
+selected x86 vector events to refine that scheduler model.
+
+``irqstate`` does not consume IRQ action or scheduler entry/exit events.  It
+observes generic context boundaries, so multiple actions in one interrupt and
+an action dispatched through ``generic_handle_irq_safe()`` do not change its
+state.  On PREEMPT_RT it uses task switches only to follow the active softirq
+context. ``irqexit`` observes the surrounding IRQ-preemption loop and its
+task owner, rather than inferring that protocol from individual scheduler
+entry/exit events used by ``sts``.
+
+.. list-table:: Monitor coverage
+   :header-rows: 1
+
+   * - Property or event
+     - ``sched/sts``
+     - ``irq/irqstate``
+   * - IRQ disable and enable ordering
+     - yes
+     - no
+   * - IRQ action entry
+     - yes
+     - no
+   * - scheduler entry and exit
+     - yes
+     - no
+   * - task switch
+     - yes
+     - PREEMPT_RT softirq context only
+   * - ``irq_enter[_rcu]()``/``irq_exit[_rcu]()`` hardirq context
+     - no
+     - yes
+   * - complete serving-softirq context
+     - no
+     - yes
+   * - hardirq interruption of a softirq
+     - no
+     - yes
+
+Coverage limits
+---------------
+
+The context tracepoints are emitted by ``irq_enter_rcu()`` and
+``irq_exit_rcu()``. Softirq boundaries come from the RT serving-bit updates
+or the non-RT generic processing loop. Consequently this monitor cannot
+observe:
+
+- the early architecture entry interval before ``irq_enter_rcu()``;
+- paths which directly use ``__irq_enter()`` and ``__irq_exit()``, such as
+  the arm64 APEI SEA irq-work interval;
+- architecture or special-vector paths which use only
+  ``__irq_enter_raw()`` and ``__irq_exit_raw()`` (including x86 simple system
+  vectors);
+- NMI entry and exit; or
+- instrumentation reached while removing hardirq-count or non-RT
+  serving-softirq state, work after those removals, return from
+  ``irq_exit_rcu()``, the conditional reschedule check, and
+  architecture-specific state restoration.
+
+``irqexit`` checks ``preempt_schedule_irq()`` separately. It does not join
+that helper to the preceding ``irqstate`` instance or model an architecture's
+entire exit.
+
+The standard hardirq tracepoints describe individual IRQ actions rather than
+physical interrupt boundaries.  They are deliberately not used: synthetic
+dispatch and software resend can execute an action outside hardirq context,
+and one interrupt can execute several actions.
+
+These limitations are intentional.  A later architecture hook may provide a
+deferred raw-entry marker for the very-early interval.  Such an addition needs
+a separate event contract and does not change the meaning of ``irqstate``.
+
+Enabling the monitor
+--------------------
+
+With tracefs mounted at ``/sys/kernel/tracing``::
+
+  # cd /sys/kernel/tracing/rv
+  # grep -x irq:irqstate available_monitors
+  # echo irqstate > enabled_monitors
+  # echo irqexit >> enabled_monitors
+  # echo nop > monitors/irq/irqstate/reactors
+  # echo nop > monitors/irq/irqexit/reactors
+
+Use the ``nop`` reactor during initial qualification.  Select the ``panic``
+reactor only after unexplained violations have been excluded on the target
+configuration.
-- 
2.39.5 (Apple Git-154)

